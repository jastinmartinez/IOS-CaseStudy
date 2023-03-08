import UIKit

struct Activity: Equatable {
    let date: Date
    let description: String
}

struct Day: Hashable {
    let date: Date
    
    init(date: Date) {
        let unitFlag = Calendar.current.dateComponents([.day, .month, .year], from: date)
        guard let dateFromUnitFlag = Calendar.current.date(from: unitFlag) else {
            self.date = date
            return
        }
        self.date = dateFromUnitFlag
    }
}

struct TravelPlans {
    typealias Trips = [Day: [Activity]]
    private var trips = Trips()
    
    init(activities: [Activity]) {
        self.trips = Dictionary(grouping: activities, by: { activity -> Day in
            Day(date: activity.date)
        })
    }
}
