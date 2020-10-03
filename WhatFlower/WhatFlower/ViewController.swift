//
//  ViewController.swift
//  WhatFlower
//
//  Created by Yurii Sameliuk on 09/01/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    let wikiUrl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // esli ystanawliwaem imagePicker.allowsEditing = true ,to nužno info[.editedImage]
        if let userPickedImage = info[.editedImage] as? UIImage {
            
            //imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            
            detect(ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func detect(_ image: CIImage) {
        // sozdaem kontejner
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Loadind CoreML Failed")
        }
        // sozdaem zapros
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results?.first as? VNClassificationObservation else {
                fatalError("Model Failed to process image")
                 
                
            }
            print(results)
            // capitalized- tekst w title s bolshoj bykwu
            self.navigationItem.title = results.identifier.capitalized
           
            self.requestInfo(flowerName: results.identifier)
           
            
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([request])
        }catch {
            print(error)
        }
    }
    
    func requestInfo(flowerName: String) {
        // parametru stroki zaprosa postroenue dlia rabotu iz Alamofire.
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500",
        ]
        
        // delaem zapros w API wiki s nazwaniem poly4enogo s foto cwetka . responseJSON - dobawliaem obrabot4ika zawershenija saprosa
        Alamofire.request(wikiUrl, method: .get, parameters: parameters).responseJSON { (response) in
            // delaem prowerky response na yspeshnost
            if response.result.isSuccess {
                print("Got the wikipedia info.")
                print(response)
                // konwertiryem response w JSON format
                let flowerJSON : JSON = JSON(response.result.value)
                // poly4aem Id stranicu
                let pageId = flowerJSON["query"]["pageids"][0].stringValue
                // poly4aem konwertirowanuj otwet ot API extract - w kotorom soderžutsia opisanie cwetka
                let flowerDescription = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
                // zagryžaem foto cwetka iz wiki
                let flowerImageURL = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                // obnowliaem izobraženie na ekrane, konwertiruja tip String w format URL
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
                // wuwodim polu4enue dannue na lable
                self.lable.text = flowerDescription
            }
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
}

