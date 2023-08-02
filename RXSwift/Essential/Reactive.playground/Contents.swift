import Foundation
import RxSwift


// it's an object that can be observed and emit events
print("PublishSubject")
let subject = PublishSubject<Int>()
subject.subscribe(onNext: {value in print(value) })
subject.on(.next(2))
subject.on(.next(1))
print("")

// Observable -> Just
print("just")
let observer = Observable.just(1)
observer.subscribe(onNext: { data in print(data) }
                   ,onError: { error in print(error) },
                   onCompleted: { print("onCompleted") },
                   onDisposed: { print("onDisposed") })
print("")

// Observable -> Empty
print("empty")
let empty = Observable<Int>.empty()
empty.subscribe(onNext: { data in print(data) }
                   ,onError: { error in print(error) },
                   onCompleted: { print("onCompleted") },
                   onDisposed: { print("onDisposed") })
print("")

// Observable -> Never
print("Never")
let never = Observable<Int>.never()
never.subscribe(onNext: { data in print(data) }
                   ,onError: { error in print(error) },
                   onCompleted: { print("onCompleted") },
                   onDisposed: { print("onDisposed") })
print("")


// Observable -> Of
print("Of")
let of = Observable<Int>.of(1,2,3,4,5,6)
of.subscribe(onNext: { data in print(data) }
                   ,onError: { error in print(error) },
                   onCompleted: { print("onCompleted") },
                   onDisposed: { print("onDisposed") })
print("")

// Observable -> Of
print("From")
let from = Observable<Int>.from(50...100)
from.subscribe(onNext: { data in print(data) }
                   ,onError: { error in print(error) },
                   onCompleted: { print("onCompleted") },
                   onDisposed: { print("onDisposed") })
print("")
