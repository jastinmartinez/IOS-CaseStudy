import Foundation
import RxSwift


let subject = PublishSubject<Int>()

subject.subscribe(onNext: {value in print(value)})

subject.on(.next(2))
subject.on(.next(1))
z
