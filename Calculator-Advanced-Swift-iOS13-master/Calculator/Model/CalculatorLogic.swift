//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Yurii Sameliuk on 04/01/2020.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    // sozdaem kortež dlia soshranenija wwodimux knopok, delija ego bez parametrow s niobjazatelnim tipom
    private var intermediateCalculation: (n1: Double , calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number 
        
    }
    
    mutating func calculate (symbol: String) -> Double? {
        
        if let n = number {
            
            //"+/-" delaem 4tobu eta knopka preobrazowuwala 4isla w otricatelnue ile pologutelnue
            switch symbol {
            case "+/-":
                return n * -1
            case "AC" :
                return 0
            case "%" :
                return n / 100 // ili * 0.01
            case "=" :
                return performTwoNumCalculation(n2: n )
            default :
                // w etoj stroke koda dannue ne obnyliajutsia , 4to priwodit pri nažatii na = k powtoreniju predidys4ej operacii
                intermediateCalculation = (n1: n, calcMethod: symbol)
               
                //print(intermediateCalculation?.n1)
                
            }
           
        }
        
       
        return number
    }
    private  mutating func performTwoNumCalculation (n2: Double) -> Double? {
        // yberaem "?"
        if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
            // deinicializiryem ostato4nue dannue predidys4ej operacii pri nažatii na znak =
             intermediateCalculation = (n1: 0.0, calcMethod: "+")
            switch operation  {
            case "+" :
                return n1 + n2
            case "-" :
                return n1 - n2
            case "×" :
                return n1 * n2
            case "÷" :
                return n1 / n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
                
            }
         
        }
         
    
        return 0.0
    }
}
