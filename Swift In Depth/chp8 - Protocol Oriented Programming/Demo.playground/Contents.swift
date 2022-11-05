import UIKit
import HealthKit

var greeting = "Hello, playground"




extension HKWorkoutActivityType: CaseIterable {
    public static var allCases: [HKWorkoutActivityType] {
        
    }
    
    
}



print(HKWorkoutActivityType.allCases)
