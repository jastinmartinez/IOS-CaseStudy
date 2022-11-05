import UIKit

protocol CryptoCurrency {
    var name: String { get }
    var symbol: String { get }
    var holdings: Double { get set }
    var price: NSDecimalNumber? { get set }
}

struct Bitcoin: CryptoCurrency {
    let name = "Bitcoin"
    let symbol = "BTC"
    var holdings: Double
    var price: NSDecimalNumber?
}

struct Ethereum: CryptoCurrency {
    let name = "Ethereum"
    let symbol = "ETH"
    var holdings: Double
    var price: NSDecimalNumber?
}

final class Portfolio<Coin: CryptoCurrency> {
    var coins: [Coin]
 
    init(coins: [Coin]) {
        self.coins = coins
    }

    func addCoin(_ newCoin: Coin) {
        coins.append(newCoin)
    }
}

let listOfCoins = [Bitcoin(holdings: 1),
                   Bitcoin(holdings: 2)]

let portafolio = Portfolio(coins: listOfCoins)

func retrievePriceRunTime(coin: CryptoCurrency, completion: ((CryptoCurrency)
     -> Void) ) {                                                          1
     // ... snip. Server returns coin with most-recent price.
    var copy = coin
    copy.price = 6000
    completion(copy)
}

func retrievePriceCompileTime<Coin: CryptoCurrency>(coin: Coin,
 completion: ((Coin) -> Void)) {                                         2
     // ... snip. Server returns coin with most-recent price.
    var copy = coin
    copy.price = 6000
    completion(copy)
}

let btc = Bitcoin(holdings: 3, price: nil)
retrievePriceRunTime(coin: btc) { (updatedCoin: CryptoCurrency) in         3
     print("Updated value runtime is \(updatedCoin.price?.doubleValue ?? 0)")
}

retrievePriceCompileTime(coin: btc) { (updatedCoin: Bitcoin) in            4
     print("Updated value compile time is \(updatedCoin.price?.doubleValue
     ?? 0)")
}
