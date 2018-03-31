// Generated using Sourcery 0.10.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// MARK: - Type Eraser for Middleware

private class _AnyMiddlewareBase<StateType>: Middleware {
    init() {
        guard type(of: self) != _AnyMiddlewareBase.self else {
            fatalError("_AnyMiddlewareBase<StateType> instances can not be created; create a subclass instance instead")
        }
    }

    func handle(event: Event, getState: @escaping GetState<StateType>, next: @escaping (Event, @escaping GetState<StateType>) -> Void) -> Void {
        fatalError("Must override")
    }
    func handle(action: Action, getState: @escaping GetState<StateType>, next: @escaping (Action, @escaping GetState<StateType>) -> Void) -> Void {
        fatalError("Must override")
    }

}

private final class _AnyMiddlewareBox<Concrete: Middleware>: _AnyMiddlewareBase<Concrete.StateType> {
    var concrete: Concrete
    typealias StateType = Concrete.StateType

    init(_ concrete: Concrete) {
        self.concrete = concrete
    }

    override func handle(event: Event, getState: @escaping GetState<StateType>, next: @escaping (Event, @escaping GetState<StateType>) -> Void) -> Void {
        return concrete.handle(event: event, getState: getState, next: next)
    }
    override func handle(action: Action, getState: @escaping GetState<StateType>, next: @escaping (Action, @escaping GetState<StateType>) -> Void) -> Void {
        return concrete.handle(action: action, getState: getState, next: next)
    }

}

final class AnyMiddleware<StateType>: Middleware {
    private let box: _AnyMiddlewareBase<StateType>

    init<Concrete: Middleware>(_ concrete: Concrete) where Concrete.StateType == StateType {
        self.box = _AnyMiddlewareBox(concrete)
    }

    func handle(event: Event, getState: @escaping GetState<StateType>, next: @escaping (Event, @escaping GetState<StateType>) -> Void) -> Void {
        return box.handle(event: event,getState: getState,next: next)
    }
    func handle(action: Action, getState: @escaping GetState<StateType>, next: @escaping (Action, @escaping GetState<StateType>) -> Void) -> Void {
        return box.handle(action: action,getState: getState,next: next)
    }

}

// MARK: - Type Eraser for Reducer

private class _AnyReducerBase<StateType>: Reducer {
    init() {
        guard type(of: self) != _AnyReducerBase.self else {
            fatalError("_AnyReducerBase<StateType> instances can not be created; create a subclass instance instead")
        }
    }

    func reduce(_ currentState: StateType, action: Action) -> StateType {
        fatalError("Must override")
    }

}

private final class _AnyReducerBox<Concrete: Reducer>: _AnyReducerBase<Concrete.StateType> {
    var concrete: Concrete
    typealias StateType = Concrete.StateType

    init(_ concrete: Concrete) {
        self.concrete = concrete
    }

    override func reduce(_ currentState: StateType, action: Action) -> StateType {
        return concrete.reduce(currentState, action: action)
    }

}

final class AnyReducer<StateType>: Reducer {
    private let box: _AnyReducerBase<StateType>

    init<Concrete: Reducer>(_ concrete: Concrete) where Concrete.StateType == StateType {
        self.box = _AnyReducerBox(concrete)
    }

    func reduce(_ currentState: StateType, action: Action) -> StateType {
        return box.reduce(currentState,action: action)
    }

}

// MARK: - Type Eraser for SideEffectFactory

private class _AnySideEffectFactoryBase<StateType>: SideEffectFactory {
    init() {
        guard type(of: self) != _AnySideEffectFactoryBase.self else {
            fatalError("_AnySideEffectFactoryBase<StateType> instances can not be created; create a subclass instance instead")
        }
    }

    func evaluate(event: Event, getState: @escaping GetState<StateType>) -> Observable<Action> {
        fatalError("Must override")
    }

}

private final class _AnySideEffectFactoryBox<Concrete: SideEffectFactory>: _AnySideEffectFactoryBase<Concrete.StateType> {
    var concrete: Concrete
    typealias StateType = Concrete.StateType

    init(_ concrete: Concrete) {
        self.concrete = concrete
    }

    override func evaluate(event: Event, getState: @escaping GetState<StateType>) -> Observable<Action> {
        return concrete.evaluate(event: event, getState: getState)
    }

}

final class AnySideEffectFactory<StateType>: SideEffectFactory {
    private let box: _AnySideEffectFactoryBase<StateType>

    init<Concrete: SideEffectFactory>(_ concrete: Concrete) where Concrete.StateType == StateType {
        self.box = _AnySideEffectFactoryBox(concrete)
    }

    func evaluate(event: Event, getState: @escaping GetState<StateType>) -> Observable<Action> {
        return box.evaluate(event: event,getState: getState)
    }

}
