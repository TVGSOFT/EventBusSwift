//
//  EventPost.swift
//  Model
//
//  Created by Giáp Trần on 9/19/16.
//  Copyright © 2016 TVG Soft, Inc. All rights reserved.
//

class EventPost {

    // MARK: Property
    
    internal var object: Any?
    internal var isActive: Bool = false
    
    private var observers = [String: Any]()
    private var handlers = [String: EventBusHandler]()
    
    internal var isEmpty: Bool {
        return observers.isEmpty
    }
    
    // MARK: Internal method

    internal func add(observer: Any, handler: @escaping EventBusHandler) {
        let key = String(describing: type(of: observer))
        if let _ = observers[key], let _ = handlers[key] {
            fatalError("\(key) has registered event. Please unregister before use it again!")
        }
        observers[key] = observer
        handlers[key] = handler
    }
    
    internal func remove(observer: Any) {
        let key = String(describing: type(of: observer))
        observers[key] = nil
        handlers[key] = nil
    }
    
    internal func contains(observer: Any) -> Bool {
        let key = String(describing: type(of: observer))
        return observers[key] != nil
    }
    
    internal func send() {
        for (_, handler) in handlers {
            handler(object)
        }
    }
    
}
