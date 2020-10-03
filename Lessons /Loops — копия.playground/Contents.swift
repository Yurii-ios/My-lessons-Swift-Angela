import UIKit
//
//let arrayOfNumbers = [1,5,3,6,2,7,23,34]
//
//var sum = 0
//
//for number in arrayOfNumbers {
//    sum += number
//   print(sum)
//}

//func beerSong(beerCountStart totalBottles: Int, beerCountEnd: Int) -> String {
//    var lyrics: String = " "
//
//    for number in (totalBottles...beerCountEnd).reversed() {
//        let newLine: String = " \n \( number) bottles of beer on the wall, \( number) bottles of beer.\nTake one down and pass it around, \(number - 1) bottles of beer on the wall.\n "
//        lyrics += newLine
//    }
//    lyrics += "\nNo more bottles of beer on the wall, no more bottles of beer.\nGo to the store and by some more, 99 bottles of beer on the wall.\n"
//    return lyrics
//}
//
//var beer = beerSong(beerCountStart: 5, beerCountEnd: 10)
//
//print(beer)

func fibonacci (until n : Int) {
    print(0)
    print(1)
    
    var num1 = 0
    var num2 = 1
    
    for _ in 0...n{
        
        let num = num1+num2
        print(num)
        
        num1 = num2
        num2 = num
    }
        
    }
    
    
fibonacci(until: 8)
