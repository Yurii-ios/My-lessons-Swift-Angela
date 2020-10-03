//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()
    
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        
        //MARK: formated 2 decimals values( 1.34) i wuwod na ekran
        
        let height = String (format: "%.2f", sender.value)
        heightLabel.text = "\(height)m"
    }
    
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        
        let weight = String (format: "%.0f", sender.value)
        
        weightLabel.text = "\(weight)kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = heightSlider.value
        let weidht = weightSlider.value
        
        calculatorBrain.calculateBMI(height: height, weidht: weidht)
        
        //MARK:inicializacija result view controller pri pomos4i Segue
        self.performSegue(withIdentifier: "goToResaults", sender: self)
        
    }
    // MARK: Get the new view controller using segue.destination
    //MARK: Pass the selected object to the new view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //MARK: proveriaem raven li nash 1 view 2 - my
        if segue.identifier == "goToResaults" {
            //MARK: sozdanie novoj ssulki na novuj view controller ukazuvaja na "var bmiValue" v result controllere
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
            
            
        }
    }
    
    
}

