import UIKit
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true

let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInitiated)

let base = "https://via.placeholder.com/150/"
let ids = [ "92c952", "771796", "56a8c2", "f66b97", "d32776", "24f355", "771796", "b0f7cc", "1ee8a4" ]

var imageList: [UIImage] = []

for id in ids {
    queue.async(group: group, execute: {
        guard let url = URL(string: base + id) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        group.enter()
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            defer {
                group.leave()
            }
            guard error == nil else {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                guard response.statusCode == 200 else {
                    return
                }
                
                guard let data = data else {
                    return
                }
             
                guard let image = UIImage(data: data) else {
                    return
                }
                
                imageList.append(image)
            }
        }.resume()
    })
}


group.notify(queue: .global()) {
    print(imageList.count == ids.count)
    imageList = []
    PlaygroundPage.current.finishExecution()
}

let concurrentOperations = 5
let dispatchSemaphore = DispatchSemaphore(value: concurrentOperations)

PlaygroundPage.current.needsIndefiniteExecution = true

for id in ids {
    queue.async(group: group, execute: {
        guard let url = URL(string: base + id) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        group.enter()
        dispatchSemaphore.wait()
        print("start with \(id)")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            defer {
                dispatchSemaphore.signal()
                group.leave()
            }
            guard error == nil else {
                return
            }
            
            if let response = response as? HTTPURLResponse {
                guard response.statusCode == 200 else {
                    return
                }
                
                guard let data = data else {
                    return
                }
             
                guard let image = UIImage(data: data) else {
                    return
                }
                
                imageList.append(image)
                print("end with \(id)")
            }
        }.resume()
    })
}


group.notify(queue: .global()) {
    print(imageList.count == ids.count)
    imageList = []
    PlaygroundPage.current.finishExecution()
}
