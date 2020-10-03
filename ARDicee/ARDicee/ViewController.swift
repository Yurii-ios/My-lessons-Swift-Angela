//
//  ViewController.swift
//  ARDicee
//
//  Created by Yurii Sameliuk on 21/01/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    var diceArray = [SCNNode]()
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // zapusk debagpaneli dlia otladki priloženija
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        
        // Set the view's delegate
        sceneView.delegate = self
        //sozdaem kyb. 0.1 = 10 cm
        //let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        // let sphere = SCNSphere(radius: 0.25)
        
        //tak kak mu sosdaem kyb w belom cwete , mu sozdaem dlia nego wid
        //        let material = SCNMaterial()
        //        material.diffuse.contents = UIImage(named: "art.scnassets/8k_moon.jpg")
        //
        //dobawliaem sozdanuj nami wid na kyb
        //sphere.materials = [material]
        
        // zadaem pozicii dlia kyba w 3d prostranstwe
        // let node = SCNNode()
        // 0.1 = 10 cm
        //node.position = .init(0, 0.1, -0.5)
        
        // peredaem pozicuju kuby
        // node.geometry = sphere
        // wuwodim sozdanuj nami obekt kuba na ekran dobawliaja do4ernuju scenu k ryt scene i priswaiwaem eto wse view
        //sceneView.scene.rootNode.addChildNode(node)
        
        // dobawliaem swet 4tobu obekt kyba bul bolee realisti4nee 3d
        sceneView.automaticallyUpdatesLighting = true
        
        // Show statistic such as fps and timing information
        //sceneView.showsStatistics = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // prowerka na podderžky odnoj iz dwyx konfigyracij
        print(ARWorldTrackingConfiguration.isSupported)
        print(ARConfiguration.isSupported)
        
        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - Dice Rendering Methods
    
    // wuzuwaem metod kotoruj srabatuwaet pri nažatii na ekran
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // touches.first - perwuj obekt kotoruj do kotorogo dotronylsia polzowatel na ekrane
        if let touch = touches.first {
            let touchLocation = touch.location(in: sceneView)
            //peredeluwaem 2d kasanije w 3d
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            
            if let hitResult = results.first {
                //Create a new scene
                addDice(atLocation: hitResult)
            }
        }
    }
    
    func addDice(atLocation location: ARHitTestResult) {
        let diceScene = SCNScene(named: "art.scnassets/diceCollada copy.scn")!
        // "Dice" eto identity w fajle diceCollada copy.scn
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            
            // zadaem pozicuju nowomy yzly kybikow
            diceNode.position = SCNVector3(
                x: location.worldTransform.columns.3.x,
                // diceNode.boundingSphere.radius - 4tobu kubiki ne prowaliwalis i buli na powerxnosti
                y: location.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                z: location.worldTransform.columns.3.z)
            // dobawliaem w sozdanuj masiw wse kybiki srazy
            diceArray.append(diceNode)
            // podklu4aemsia k etoj scene
            sceneView.scene.rootNode.addChildNode(diceNode)
            
            roll(dice: diceNode)
        }
        
    }
    
    func roll(dice: SCNNode) {
        // delaem randomnoe koli4estwo to4ek na kybike. po ymol4aniju wsegda 1 to4ka.
        let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        // wras4aem kybiki pri pomos4i randomX i randomZ
        dice.runAction(SCNAction.rotateBy(x: CGFloat(randomX) * 5, y: 0, z: CGFloat(randomZ) * 5, duration: 0.5))
        
    }
    
    func rollAll() {
        if !diceArray.isEmpty {
            for dice in diceArray{
                roll(dice: dice)
            }
        }
    }
    
    
    
    
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        rollAll()
        
    }
    
    @IBAction func removeAllDice(_ sender: UIBarButtonItem) {
        
        if !diceArray.isEmpty {
            for dice in diceArray {
                dice.removeFromParentNode()
            }
        }
        
    }
    // wstriaxnyw telefon mu možem dwigat kybikami
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }
    
    //MARK: - ARSCNViewDelegateMethods
    
    // kak tolko configuration.planeDetection = .horizontal obnaružuw gorizontalnuju powerchnost w perweju o4ered wuzowet etot metod i ego kod wnytri , dlia razmes4enija objekta
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // proweriaem priwjazan li jakor k 4emy libo
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
     let planeNode =  createPlane(withPlaneAnchor: planeAnchor)
       // podklu4aem nash objekt k scene
       node.addChildNode(planeNode)

       //print("plane detected")
    }
    
    //MARK: - plane Rendering Methods
    
    func createPlane(withPlaneAnchor planeAnchor: ARPlaneAnchor ) -> SCNNode {
        // sozdaem ploskost w scene. podobno tomy kak mu sozdawali sfery i korobky
              let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))

              let planeNode = SCNNode()
              planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
              // perewora4iwaem sceny na 90º , ibo  po ymol4aniju ona wertikalnaja. 1п rad = 180º
              planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
              //dobawliaem bolshe detalizacii
              plane.widthSegmentCount = 10
              plane.heightSegmentCount = 10

              let gridMaterial = SCNMaterial()
              gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
              // dobawliaem obolo4ky nashemy obekty
              plane.materials = [gridMaterial]

              // ystanawliwaem geometriju nashemy ploskomy yzlu
              planeNode.geometry = plane
        
        return planeNode
    }
}


