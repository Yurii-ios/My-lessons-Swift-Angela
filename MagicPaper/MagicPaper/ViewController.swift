//
//  ViewController.swift
//  MagicPaper
//
//  Created by Yurii Sameliuk on 30/01/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageTrack = ARReferenceImage.referenceImages(inGroupNamed: "NewsPaperImages", bundle: .main) {
            
            configuration.detectionImages = imageTrack
            configuration.maximumNumberOfTrackedImages = 1
            
        }
        
        

        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
    }

    // MARK: - ARSCNViewDelegate
    // metod nachodit znakomoe izobraženije
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
       
        let node = SCNNode()
        
       if let imageAnchor = anchor as? ARImageAnchor {
        
        let videoNode = SKVideoNode(fileNamed: "harry.mp4")
        videoNode.play()
        // zadaem razshurenije video
        let videoScene = SKScene(size: CGSize(width: 480, height: 360))
        
        videoScene.addChild(videoNode)
        videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
        // perewora4iwaem wideo na 180º
        videoNode.yScale = -1.0
            
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        plane.firstMaterial?.diffuse.contents =  videoScene //UIColor.init(white: 1, alpha: 0.5) - dobawliaem ne w sly4ae s video
        
        let planeNode = SCNNode(geometry: plane)
        
        node.eulerAngles.x = -.pi / 2
        node.addChildNode(planeNode)
        
        }
        
        return node
    }
}
