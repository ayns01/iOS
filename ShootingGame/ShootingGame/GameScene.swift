//
//  GameScene.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-06.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit
import GameplayKit

//衝突判定で使うビットを構造体で作る。
struct PhysicsCategories {
    static let none: UInt32 = 0
    static let player: UInt32 = 0x1 << 1 //1
    static let laser: UInt32 = 0x1 << 2 //2
    static let enemy: UInt32 = 0x1 << 3 //4
    static let boss: UInt32 = 0x1 << 4 //8
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    //ゲーム中にplayerを参照する必要があるのでplayerのパラメーターを作成します
    var player: SKSpriteNode!
    
    var enemy: SKSpriteNode!
    
    var boss: SKSpriteNode!
    
    var touchLocation: CGPoint!
    
    var sweetArray = ["candy", "doughnut", "macaron", "icecream"]
    
    let waves = Bundle.main.decode([Wave].self, from: "waves.json")
    let enemyTypes = Bundle.main.decode([EnemyType].self, from: "enemy-types.json")
    
    var isPlayerAlive = true
    var levelNumber = 0
    var waveNumber = 0
    
    // 0 40 80 120 160 200 240 280 320 360
    let positions = Array(stride(from: 0, through: 240, by: 20))
    
    //スコア。
    let scoreLabel = SKLabelNode()
    var score = 0
    
    // ボスを倒すために出すレーザーの回数。
    var bossKillNumber = 5
    
    //Timerクラスを使うためのプロパティを作成。
    var getTimer: Timer!
    
    //BGM用のパラメーターを作成。
    var backgroundMusic = SKAudioNode()
    //BGMで流れるゲーム音楽。
    let musicURL = Bundle.main.url(forResource: "music_funky_walk", withExtension: "mp3")
    
    //レーザー音。
    let sweetSound = SKAction.playSoundFileNamed("laser.mp3", waitForCompletion: false)
    
    // 爆発音。
    let explosionSound = SKAction.playSoundFileNamed("get_sweets.mp3", waitForCompletion: false)

   
    // ゲーム開始時に呼び出される部分。
    override func didMove(to view: SKView) {
        
        // ゲームに重力シュミレートを追加する
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        // 物理衝突があったことを通知するプロトコル
        physicsWorld.contactDelegate = self
        
        createStarDust()
        
        createPlayer()
        
        createBossEnemy()
        
        //0.5秒間隔でcreateEnemy()を呼び出す。
        if getTimer == nil {
            getTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        }

        //BGM用の音楽をセットする
        backgroundMusic = SKAudioNode(url: musicURL!)
        //GameSceneに追加する。
        addChild(backgroundMusic)
        
        scoreLabel.position = CGPoint(x: frame.size.width * 0.15, y: frame.size.height * 0.88)
        scoreLabel.zPosition = 10
        scoreLabel.fontColor = #colorLiteral(red: 0.5855464339, green: 0.9720957875, blue: 0.6153635979, alpha: 1)
        scoreLabel.fontSize = 20
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.text = String(score)
        addChild(scoreLabel)
    }
    
    func killEnemy() {
        score += 1
        scoreLabel.text = String(score)
    }
    
    @objc func createEnemy() {
        //配列の中身をランダムに並び替える。
        sweetArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: sweetArray) as! [String]
        
        //テクスチャの名前を配列の０番目に指定する。
        let enemyTexture = SKTexture(imageNamed: sweetArray[0])
        
        //SpriteNodeを作成する。
        enemy = SKSpriteNode(texture: enemyTexture)
        
        //物理ボディを作成する。
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: max(enemyTexture.size().width / 2, enemyTexture.size().height / 2))
        
        //カテゴリマスクを設定する。
        enemy.physicsBody!.categoryBitMask = PhysicsCategories.enemy
        
        //衝突マスクを設定する。
        enemy.physicsBody!.collisionBitMask = PhysicsCategories.none
        
        //衝突検出マスクを設定する。
        enemy.physicsBody!.contactTestBitMask = PhysicsCategories.player | PhysicsCategories.laser
        
        enemy.zPosition = 5
        
        enemy.name = "enemy"
        
        enemy.setScale(0.15)
        
        //指定して範囲内で乱数を生成する。
        let randomDistribute = GKRandomSource.sharedRandom().nextInt(upperBound: Int((frame.size.width)))
        
        //出現位置を設定する。
        enemy.position = CGPoint(x: CGFloat(randomDistribute), y: frame.size.height)
        
        //GameSceneに追加する。
        addChild(enemy)
        
        //出現位置から画面の外まで５秒かけて移動する。
        let moveEnemy = SKAction.moveTo(y: -self.size.height + enemy.size.height, duration: 5)
        
        //GameSceneから削除する。
        let moveReset = SKAction.removeFromParent()
        
        //順番にアクションを実行するsequenceを作る。
        let moveSequence = SKAction.sequence([moveEnemy, moveReset])
        
        //sequenceアクションをループさせる。
        let moveForever = SKAction.repeatForever(moveSequence)
        
        //アクションを実行する。
        enemy.run(moveForever)
    }
    
    func createStarDust() {
        // スターダストの生成
        if let particles = SKEmitterNode(fileNamed: "Starfield") {
            particles.position = CGPoint(x: frame.maxX / 2, y: frame.maxY)
            particles.advanceSimulationTime(60)
            particles.zPosition = 0
            addChild(particles)
        }
    }
    
    func createLaser() {
        
        //SpriteNodeを作成する
        let laser = SKSpriteNode(imageNamed: "enemy1Weapon")
        
        //物理ボディを設定。
        laser.physicsBody = SKPhysicsBody(circleOfRadius: max(laser.size.width / 2, laser.size.height / 2))
        
        //物理ボディにカテゴリマスクを設定する。
        laser.physicsBody!.categoryBitMask = PhysicsCategories.laser
        
        //物理ボディに衝突マスクを設定する。
        laser.physicsBody!.collisionBitMask = PhysicsCategories.none
        
        //物理ボディにコンタクトテストマスクを設定する。
        laser.physicsBody!.contactTestBitMask = PhysicsCategories.enemy
        
        //重なり順番を5に設定する。
        laser.zPosition = 5
        
        //名前をつける。
        laser.name = "laser"
        
        //ポジションをplayerのすぐ上にする。
        laser.position = CGPoint(x: player.position.x + player.frame.width * 0.8, y: player.position.y)
        
        //GameSceneに追加する。
        addChild(laser)
        
        // 1秒間隔でlaserの高さ分Y軸方向に移動する。
        let moveLaser = SKAction.moveTo(x: self.size.width + laser.size.width, duration: 1)
        
        //GameSceneから削除。
        let moveReset = SKAction.removeFromParent()
        
        //順番にアクションを実行するsequenceを作る。
        let moveSequence = SKAction.sequence([sweetSound, moveLaser, moveReset])
        
        //アクションを実行する。
        laser.run(moveSequence)
    }

    
    func createPlayer() {
        let playerTexture = SKTexture(imageNamed: "rocket")
        //SpriteNodeを作成する
        player = SKSpriteNode(texture: playerTexture)
        
        //衝突判定のために物理ボディを設定する。
        player.physicsBody = SKPhysicsBody(circleOfRadius: max(player.size.width / 2, player.size.height / 2))

        //物理ボディにカテゴリマスクを設定する。
        player.physicsBody!.categoryBitMask = PhysicsCategories.player
        
        //物理ボディに衝突マスクを設定する。
        // collisionBitMaskに０を指定すると、全ての衝突を受け入れることになる。
        player.physicsBody!.collisionBitMask = PhysicsCategories.none
        
        //物理ボディにコンタクトテストマスクを設定する。
        // 衝突したことにより発生する処理を行いたいとき。
        player.physicsBody!.contactTestBitMask = PhysicsCategories.enemy
        
        player.setScale(0.1)
        
        player.zPosition = 10
        //名前をつける。
        player.name = "player"
        //最初の出現位置を決める。
        player.position = CGPoint(x: frame.minX + 50, y: UIScreen.main.bounds.height * 0.5)
        
        //GameSceneに追加する。
        addChild(player)
    }
    
    func createBossEnemy() {
        let bossTexture = SKTexture(imageNamed: "perocan")
        
        boss = SKSpriteNode(texture: bossTexture)
        
        boss.physicsBody = SKPhysicsBody(circleOfRadius: max(boss.size.width / 2, boss.size.height / 2))
        
        boss.physicsBody!.categoryBitMask = PhysicsCategories.boss
        
        boss.physicsBody!.collisionBitMask = PhysicsCategories.laser
        
        boss.physicsBody!.contactTestBitMask = PhysicsCategories.laser
        
        boss.setScale(0.4)
        
        boss.zPosition = 10
        
        boss.name = "enemyBoss"
        
        addChild(boss)
        
//        let moveBossPath = UIBezierPath()
//        moveBossPath.move(to: .zero)
//        moveBossPath.addCurve(to: CGPoint(x: frame.maxX - boss.size.width, y: 0),
//                              controlPoint1: CGPoint(x: frame.minX + 100, y: UIScreen.main.bounds.height * 0.5), controlPoint2: CGPoint(x: frame.minX + 200, y: UIScreen.main.bounds.height * 0.3))
//
        // make the curved line
        let line2 = UIBezierPath()
        line2.move(to: CGPoint(x:75, y:frame.size.height))
        line2.addCurve(to: CGPoint(x:187.5, y:100), controlPoint1: CGPoint(x:75, y:40), controlPoint2: CGPoint(x:100, y:100))
        line2.addCurve(to: CGPoint(x:300, y:25), controlPoint1: CGPoint(x:270, y:100), controlPoint2: CGPoint(x:300, y:40))
        line2.miterLimit = 4
        line2.lineCapStyle = .round
        
        let movement = SKAction.follow(line2.cgPath, asOffset: true, orientToPath: true, duration: 5)
        
        let moveReset = SKAction.removeFromParent()
        
        let moveSequence = SKAction.sequence([sweetSound, movement, moveReset])
        
        boss.run(moveSequence)
    }
    
    // 画面にタッチした時に呼び出される部分。
    /*
     touches: タッチ位置情報の集合
     evewnt: イベントオブジェクト
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //最初のタッチがあったら以降の処理を実行します、なければ処理を抜けます。
        guard touches.first != nil else { return }
        
        //laserを作成する関数を呼び出す。
        createLaser()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            touchLocation = touch.location(in: self)
            player.position.x = touchLocation.x
            player.position.y = touchLocation.y
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //衝突した2つの物体のどちらかの名前が"laser"であるか判定する。
        if contact.bodyA.node?.name == "laser" || contact.bodyB.node?.name == "laser" {
            
            //bodyAの名前が"enemy"のとき。
            if contact.bodyA.node?.name == "enemy" {
                
                //爆発の画像を読み込む。
                if let explosion = SKEmitterNode(fileNamed: "ExplosionEffect") {
                    
                    //爆発の画像をenemyの位置に表示する。
                    explosion.position = (contact.bodyA.node?.position)!
                    
                    explosion.zPosition = 10
                    
                    //両方の物体をGameSceneから削除する。
                    contact.bodyA.node?.removeFromParent()
                    contact.bodyB.node?.removeFromParent()
                    
                    //GameSceneに追加する。
                    addChild(explosion)
                }
                
            } else if contact.bodyB.node?.name == "enemy" {
                
                //爆発の画像を読み込む。
                if let explosion = SKEmitterNode(fileNamed: "ExplosionEffect") {
                    
                    //爆発の画像をenemyの位置に表示する。
                    explosion.position = (contact.bodyB.node?.position)!
                    
                    //両方の物体をGameSceneから削除する。
                    contact.bodyA.node?.removeFromParent()
                    contact.bodyB.node?.removeFromParent()
                    
                    //GameSceneに追加する。
                    addChild(explosion)
                }
            }
            
            if contact.bodyA.node?.name == "enemyBoss" {
                
                bossKillNumber -= 1
                if let explosion = SKEmitterNode(fileNamed: "ExplosionBossEffect") {
                    
                    explosion.position = (contact.bodyB.node?.position)!
                    
                    contact.bodyB.node?.removeFromParent()
                    
                    addChild(explosion)
                }
                
                if bossKillNumber == 0 {
                    
                    if let explosion = SKEmitterNode(fileNamed: "ExplosionBossDefeatEffect") {
                        
                        explosion.position = (contact.bodyA.node?.position)!
                        
                        contact.bodyA.node?.removeFromParent()
                        contact.bodyB.node?.removeFromParent()
                        
                        addChild(explosion)
                    }
                }
                
            }else if contact.bodyB.node?.name == "enemyBoss" {
                
                bossKillNumber -= 1
                
                if let explosion = SKEmitterNode(fileNamed: "ExplosionBossEffect") {
                    
                    explosion.position = (contact.bodyB.node?.position)!
                    
                    contact.bodyA.node?.removeFromParent()
                    
                    addChild(explosion)
                }
                
                if bossKillNumber == 0 {
                    
                    if let explosion = SKEmitterNode(fileNamed: "ExplosionBossDefeatEffect") {
                        
                        explosion.position = (contact.bodyB.node?.position)!
                        
                        contact.bodyA.node?.removeFromParent()
                        contact.bodyB.node?.removeFromParent()
                        
                        addChild(explosion)
                    }
                }
            }
            
            
            //爆発した時のサウンドを再生する。
            run(explosionSound)
            
            killEnemy()
            
            return
        }
        
        guard contact.bodyA.node != nil && contact.bodyB.node != nil else { return }
    }

}
