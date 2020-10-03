//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Yurii Sameliuk on 24/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weidht: Float){
        //MARK: ras4et masu tela k rosty i kastomnoe vozvidenie v stepen v jazuke Swift
        let bmiValue = weidht / pow(height, 2)
        //MARK: proverka rezyltata i wuwod na ekran r s colorom
        if bmiValue < 18.5{
            bmi = BMI(value: bmiValue, advice:"Eat more pies!", color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        } else if bmiValue < 24.9{
            bmi = BMI(value: bmiValue, advice:"Fir as a fiddlet!", color:#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) )
        } else{
            bmi = BMI(value: bmiValue, advice:"Eat less pies!", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        }
    }
    func getAdvice() -> String {
        
        return bmi?.advice ?? " `No advice "
        
    }
    
    func getColor() -> UIColor{
        return bmi?.color ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    //MARK: formatirovanie Float na String s  proverkoi na nil
    func getBMIValue() -> String{
        
        let bmiToDecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiToDecimalPlace
        
    }
    
}
