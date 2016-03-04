//: Playground - noun: a place where people can play

import UIKit

for var i = 3; i < 8; i++ {
    print(i)
}


var arr = [3.0, 8.0, 2.0, 5.0]

for (index, x) in arr.enumerate() {

    arr[index] = arr[index] / 2

}
arr


var i = 1

while i < 5 {
    print(i)
    i++
}