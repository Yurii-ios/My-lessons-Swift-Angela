import UIKit

func calculator (n1: Int, n2: Int, operation: (Int,Int) -> Int) -> Int{
    return operation(n1,n2)
}

func add (no1: Int, no2: Int) -> Int {
    return no1 + no2
}


calculator(n1: 3, n2: 10) { $0 * $1}



let array = [6,2,3,9,4,1]

//func addOne(n1: Int) -> Int{
//    return n1 + 1
//
//}
let arr = array.map{$0 + 1}
print(arr)
