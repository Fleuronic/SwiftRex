import struct ReactiveSwift.SignalProducer
import class ReactiveSwift.ScopedDisposable
import class ReactiveSwift.CompositeDisposable
import SwiftRex

func observable<T>(of type: T.Type, error: Error) -> SignalProducer<T, Error> {
    return SignalProducer<T, Error> { observer, _ in
        observer.send(error: .init(error))
    }
}

func observable<T>(of values: T...) -> SignalProducer<T, Error> {
    return SignalProducer<T, Error> { observer, _ in
        values.forEach(observer.send)
        observer.sendCompleted()
    }
}

extension SignalProducer {
    func toBlocking() -> SignalProducer<[Value], Error> {
        return collect()
    }
}

extension SignalProducer where Value: Collection {
    func toArray() throws -> [Value.Element] {
        let collection = try self.single()?.dematerialize()
        return collection.map(Array.init) ?? []
    }
}

extension ScopedDisposable where Inner == CompositeDisposable {
    static func new() -> SubscriptionOwner {
        return .init(.init())
    }
}
