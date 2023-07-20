import UIKit

// get even and old value from collection
var array = [1,2,3,4,5,6]

let even: (Int) -> Bool = { return $0 % 2 == 0}
let partionEven = array.partition(by: even)

print(array[partionEven...])
print(array[..<partionEven])



