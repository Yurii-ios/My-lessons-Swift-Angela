//
//  ViewController.swift
//  SeeFood
//
//  Created by Yurii Sameliuk on 06/01/2020.
//  Copyright © 2020 Yurii Sameliuk. All rights reserved.
//
/// 4tobu priloženije zarabotalo w info.plist dobawit razreshenija  Privacy - Camera Usage Description ,   Privacy - Photo Library Usage Description
import UIKit
import CoreML
import Vision
// UIImagePickerControllerDelegate, UINavigationControllerDelegate  - dlia rabotu s kameroj
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    // sozdaem objekt UIImagePickerController
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// eto wse nastrojki kotorue nygno sdelat dlia rabotu s kameroj
        // inicializiryem delegat w proekte
        imagePicker.delegate = self
        // ystanawliwaem tip isto4nika , esle mu chotim ismenit isto4nik poly4enija dannux na .photoLibrary
        imagePicker.sourceType = .camera
        // razreshaem redaktirowat izobraženie , obrezaja ego.potomy 4to ML dolžna rabotat s menshej plos4adju izobrajenija
        imagePicker.allowsEditing = false
        ///-----------------
    }

// ispolzyem delegat UIImagePickerControllerDelegate dlia pereda4i izobraženija  modeli ML
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // isxodnoe izobraženije sdelanoe kameroj ili wubranoe iz fotoalboma polzowatelem
        if let userPickedImege = info[.originalImage] as? UIImage {
        // priswaiwaem wubranuju fotografiju polzowatelem na imageView
        imageView.image = userPickedImege
         
            //preobrazowuwaem izobraženije w specualnuj format dlia rabotu s ML , i delaem ego bolee bezopasnee
            guard let ciimage = CIImage(image: userPickedImege) else {
                fatalError("Could not convert to CIImage")
            }
            // obnaružuwaem nashe podgotowlenoe izoraženije 4tobu ego ispolzowat
            detect(image: ciimage)
        }
        //zakruwaem sbors4ik izobraženij
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        
        // dobawliaem model ML
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loadind CoreML Failed")
        }
        // sozdaem zapros kotoruj poprosit Model klasificurowat poly4enue dannue
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
            // wuwodim soobs4enie w navigationBar.title
//            if let firstresult = results.first {
//                // w rezyltatax Modeli po wwedennomy nazwaniju "hotdog" oprediliaem Hotdog eto ili net
//                if firstresult.identifier.contains("hotdog") {
//                    self.navigationItem.title = "Hotdog"
//                }else {
//                    self.navigationItem.title = "Not Hotdog"
//                }
//            }
        
            
            let first = results.first
            self.navigationItem.title = first?.identifier
            
        }
        // pomes4aem obrabotanoe izobraženije CIImage w obrabot4ik
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            //ispolzuem obrabot4ik izobraženija dlia wupolninija zaprosa klasifikacii izobraženija
        try handler.perform([request])
        }catch {
            print(error)
        }
 
    }
    
    @IBAction func cameraTaped(_ sender: UIBarButtonItem) {
        // delaem wozmožnum pri nažatii na knopky kamera wuzuwaem imagePicker
        present(imagePicker, animated: true, completion: nil)
    }
}

