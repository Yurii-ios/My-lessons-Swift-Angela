//
//  ViewController.swift
//  Poke3D
//
//  Created by Yurii Sameliuk on 29/01/2020.
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
       
        // dobawliaem 3d scene iz pokemonom isto4nik sweta, 4tobu on wugliadel estestwennee
        sceneView.automaticallyUpdatesLighting = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        // ARImageTrackingConfiguration() - ispolzyetsia dlia rabotu s izobraženiem , w osnownom kogda rabotaem tolko s odnim a ne neskonkimi izobraženijami
        let configuration = ARWorldTrackingConfiguration()
        
        //zadaem katalog s izobraženijami kotorue nyžno naiti w fizi4eskoj srede
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: .main)  {
            //opredeliaem kakie imenno izobraženija nyžno opredelit
            configuration.detectionImages = imageToTrack
            // ystanawliwaem maksimalnoe koli4estwo izobraženij dlia otsležuwanija
            configuration.maximumNumberOfTrackedImages = 2

            print("image added")
        }
        
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        // delaem prowerky na priwjazky
       if let imageAnchor = anchor as? ARImageAnchor {
        
        print(imageAnchor.referenceImage.name)
          
        // sozdaem nowyjy ploskost ispolzuja nashi izibrajenija, na kotorux eta ploskost bydet raspoložena
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
        // delaem ploskost nad kartoj prozra4nogo ottenka
        plane.firstMaterial?.diffuse.contents = UIColor.init(white: 1.0, alpha:0.5)
        
        let planeNode = SCNNode(geometry: plane)
        // perewara4iwaem ploskost s wertikalnogo položenija w gorizontalnoe
        node.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
        
        if imageAnchor.referenceImage.name == "eeve-card"{
            //dobawliaem k proekty 3d obraz pokemona
            if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
               // podkly4aem pokeScene k yzly
              if let pokeNode = pokeScene.rootNode.childNodes.first {
               // perewora4iwaem 3d sceny pokemona na 90º ,4tobu on bul na plos4ine ploskosti  nad kartoj
               pokeNode.eulerAngles.x =  .pi / 2
               planeNode.addChildNode(pokeNode)
               }
            }
        
        }
        
        if imageAnchor.referenceImage.name == "oddish-card"{
            //dobawliaem k proekty 3d obraz pokemona
            if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
               // podkly4aem pokeScene k yzly
              if let pokeNode = pokeScene.rootNode.childNodes.first {
               // perewora4iwaem 3d sceny pokemona na 90º ,4tobu on bul na plos4ine ploskosti  nad kartoj
               pokeNode.eulerAngles.x =  .pi / 2
               planeNode.addChildNode(pokeNode)
               }
            }
        
        }
        
        }
        
        return node
    }

}
