//
//  ViewController.swift
//  ARKit-Sample
//
//  Created by 酒井綾菜 on 2019-05-21.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var sphere = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
//        sceneView.debugOptions = [.showWorldOrigin]
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    func drawSphereAtOrigin() {
        
        // 1. SCNNode
        sphere = SCNNode(geometry: SCNSphere(radius: 0.05)) // 0.05 meters
        // 2. set color of sphere
        sphere.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        
        sphere.geometry?.firstMaterial?.specular.contents = UIColor.white
        
        sphere.position = SCNVector3(0, 0, 0)
        
        sceneView.scene.rootNode.addChildNode(sphere)
        
        // angles -> radians (360 degrees -> 2 * pi radians)
        // + positive -> counterclock wise
        // - negative -> clock wise
        let rotate = SCNAction.rotate(by:  2 * .pi, around: SCNVector3(0, 1, 0), duration: 5)
        sphere.runAction(SCNAction.repeatForever(rotate))
    }
    
    func movingSpaceShip() {
        let scene = SCNScene(named: "art.scnassets/ship.scn")
        // extract spaceShip from .scn file
        let spaceShip = (scene?.rootNode.childNode(withName: "ship", recursively: false))!
        spaceShip.position = SCNVector3(0.5, 0, 0)
        spaceShip.scale = SCNVector3(0.2, 0.2, 0.2)
        
        spaceShip.eulerAngles.y = .pi // 180
//        spaceShip.eulerAngles.x = .pi/4 // 45
        
        // add it to earth node
        sphere.addChildNode(spaceShip)
        
    }
    
    func drawCarnival() {
        let plane = SCNNode(geometry: SCNPlane(width: 1, height: 1))
        plane.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "carnival")
        plane.position = SCNVector3(1, 0, -2)
        plane.geometry?.firstMaterial?.isDoubleSided = true
        sceneView.scene.rootNode.addChildNode(plane)
    }
    
    func drawDounut() {
        let torus = SCNNode(geometry: SCNTorus(ringRadius: 0.09, pipeRadius: 0.05))
        
        torus.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        torus.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        torus.position = SCNVector3(0.3, 0, 0)
        torus.eulerAngles.x = .pi/2
        sceneView.scene.rootNode.addChildNode(torus)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        drawSphereAtOrigin()
        movingSpaceShip()
        drawCarnival()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
