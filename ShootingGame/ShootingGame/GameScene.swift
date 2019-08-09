//
//  GameScene.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-06.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //ゲーム中にplayerを参照する必要があるのでplayerのパラメーターを作成します
    var player: SKSpriteNode!
    
    var enemy: SKSpriteNode!
    
    var touchLocation: CGPoint!
    
    //変数に配列で４種類の名前を入れる。
    var enemyArray = ["candy", "doughnut", "enemy3", "enemy4"]
    
    //Timerクラスを使うためのプロパティを作成。
    var getTimer: Timer!
    
    //サウンド再生用のプロパティを作成。
//    let explosionSound = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
    
    //BGM用のパラメーターを作成。
    var backgroundMusic = SKAudioNode()
    //BGMで流れるゲーム音楽。
    let musicURL = Bundle.main.url(forResource: "music_funky_walk", withExtension: "mp3")
    
    //衝突判定で使うビットを構造体で作る。
    struct PhysicsCategories {
        static let none: UInt32 = 0
        static let player: UInt32 = 0x1 << 1 //1
        static let laser: UInt32 = 0x1 << 2 //2
        static let enemy: UInt32 = 0x1 << 3 //3
    }

   
    // ゲーム開始時に呼び出される部分。
    override func didMove(to view: SKView) {
        
        // ゲームに重力シュミレートを追加する
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        // 物理衝突があったことを通知するプロトコル
        physicsWorld.contactDelegate = self
        
        createStarDust()
        
        createPlayer()
        
        //0.5秒間隔でcreateEnemy()を呼び出す。
        if getTimer == nil {
            getTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        }

        //BGM用の音楽をセットする
        backgroundMusic = SKAudioNode(url: musicURL!)
        //GameSceneに追加する。
        addChild(backgroundMusic)
    }
    
    @objc func createEnemy() {
        //配列の中身をランダムに並び替える。
        enemyArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemyArray) as! [String]
        
        //テクスチャの名前を配列の０番目に指定する。
        let enemyTexture = SKTexture(imageNamed: enemyArray[0])
        
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
        
        enemy.setScale(0.2)
        
        //指定して範囲内で乱数を生成する。
//        let randomDistribute = GKRandomDistribution(lowestValue: 0, highestValue: Int((self.size.height) - enemy.size.height))
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
            particles.position = CGPoint(x: frame.maxX, y: UIScreen.main.bounds.height * 0.05)
            particles.advanceSimulationTime(60)
            particles.zPosition = 0
            addChild(particles)
        }
    }
    
    func createPlayer() {
        let playerTexture = SKTexture(imageNamed: "player")
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
        
        
        player.setScale(0.5)
        
        player.zPosition = 10
        //名前をつける。
        player.name = "player"
        //最初の出現位置を決める。
        player.position = CGPoint(x: frame.minX + 55, y: UIScreen.main.bounds.height * 0.05)
        
        //GameSceneに追加する。
        addChild(player)
    }
    
    // 画面にタッチした時に呼び出される部分。
    /*
     touches: タッチ位置情報の集合
     evewnt: イベントオブジェクト
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            touchLocation = touch.location(in: self)
            player.position.x = touchLocation.x
            player.position.y = touchLocation.y
        }
    }

}
