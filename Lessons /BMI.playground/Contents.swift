

// Task 74 (3.10.2019)

func bmi( weight: Double, height: Double ) -> String{
    
    let calc = weight / (height * height ).rounded()
    
  
    if calc > 25 {
        return "\(calc) you have many bmi"
    }
    else if calc > 18.5 && calc <= 25 {
        return "\(calc)you have a normal bmi"
    }
    else {
        return "\(calc)your have low bmi"
    }
    
}

var index = bmi(weight: 90, height: 1.68)
    
print(index)
