
import UIKit

// Contract
protocol FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

// Contract Delegate
class FeedViewController: UIViewController {
    private var loader: FeedLoader!
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFeed()
    }
    
    private func getFeed() {
        self.loader.loadFeed { feed in
            print(feed)
        }
    }
}

// Implement `FeedLoader` contract can fecth some data from (Networking)
class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // Simulate network call
        Thread.sleep(until: Date() + 2)
        completion(["Network", "Network 2"])
    }
}


// Implement `FeedLoader` contract can fecth some data from (Cache, Database)
class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        completion(["Local", "Local 2"])
    }
}

// Network Available
struct Reachability {
    static let networkAvailable: Bool = false
}

// extend of funcionality without changing any implementation detail inside `FeedViewController`
class RemoteWithLocalFallBackFeedLoader: FeedLoader {
    private let remote: RemoteFeedLoader
    private let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        if Reachability.networkAvailable {
            self.remote.loadFeed(completion: completion)
        } else {
            self.local.loadFeed(completion: completion)
        }
    }
}

let feedViewController1 = FeedViewController(loader: RemoteFeedLoader())
feedViewController1.loadViewIfNeeded()

let feedViewController2 = FeedViewController(loader: LocalFeedLoader())
feedViewController2.loadViewIfNeeded()

let feedViewController3 = FeedViewController(loader: RemoteWithLocalFallBackFeedLoader(remote: RemoteFeedLoader(),
                                                                                       local: LocalFeedLoader()))
feedViewController3.loadViewIfNeeded()
