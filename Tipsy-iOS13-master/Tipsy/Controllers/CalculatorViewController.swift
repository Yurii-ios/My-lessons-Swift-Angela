//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Yurii Sameliuk on 27/10/2019.
//  Copyright © 2019. All rights reserved.
//

import UIKit


class CalculatorViewController: UIViewController {
    var battons = 0.0
    var numberPeople = 2
    var textField: String = " "
    var total: Double = 0.0
    var totalCount: String = "0.0"
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        // Отмена выбора всех кнопок подсказок через IBOutlets
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Сделать кнопку, которая активировала IBAction, выбранной.
        sender.isSelected = true
        
        // Получить текущий заголовок кнопки, которая была нажата.
        let batton = sender.currentTitle!
        // Удаляем последний символ (%) из заголовка, затем превращаем его обратно в строку.
        let dropten = String(batton.dropLast())
        
        battons = Double(dropten)! / 100.0
        
        // prinimaem dannue s tekst filda
        textField = billTextField.text!
        
        
        // Если текст не является пустой строкой ""
        if textField != " " {
            total = Double (textField)!
        }
        // skruwaem klawiatyry
        billTextField.endEditing(true)
        
        }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //Получаем значение пошагового значения, используя sender.value, округляем его до целого числа, затем устанавливаем его как текст в
        // splitNumberLabel
        
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        
        numberPeople = Int(sender.value)
        sender.maximumValue = 25
        sender.stepValue = 1
        sender.autorepeat = true
        sender.wraps = true
        sender.isContinuous = true
        
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let results = total *  (1 + battons) / Double(numberPeople)
        
        totalCount = String(format:"%.1f", results)
        
        self.performSegue(withIdentifier: "goToResaults", sender: self)
        
        }
    //Подгот. к использованию метода Segway
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // proverka sootwetctwyet li nach segue nazwaniyu "goToResaults"
        if segue.identifier == "goToResaults" {
            // priswaiwaem  segue.destination nachemy wtoromy okny ResaultsViewController dla togo 4tobu wuzwat ego peremennoy totalcount ispolzyya kly4ewoe slowo " as!  "
            let destinationVC = segue.destination as! ResultsViewController
            // wuzuwaem peremennyy ResultsViewControllera
            destinationVC.totalCount = self.totalCount
            destinationVC.splitResaults = " Split between \(numberPeople) people, with \(String(format: "%.0f",battons * 100)) % tip. "
        }
    }
    
    
}

