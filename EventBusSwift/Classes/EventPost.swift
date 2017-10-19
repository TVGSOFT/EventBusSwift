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
    
    private var observers = [UInt: WeakObject]()
    private var handlers = [UInt: EventBusHandler]()
    
    internal var isEmpty: Bool {
        return observers.isEmpty
    }
    
    // MARK: Internal method

    internal func add(observer: AnyObject, handler: @escaping EventBusHandler) {
        let key = UInt(bitPattern: ObjectIdentifier(observer))
        observers[key] = WeakObject(value: observer)
        handlers[key] = handler
    
        clean()
    }
    
    internal func remove(observer: AnyObject) {
        let key = UInt(bitPattern: ObjectIdentifier(observer))
        
        observers[key] = nil
        handlers[key] = nil
    }
    
    internal func contains(observer: AnyObject) -> Bool {
        let key = UInt(bitPattern: ObjectIdentifier(observer))
        return observers[key] != nil
    }
    
    internal func send() {
        for (_, handler) in handlers {
            handler(object)
        }
    }
    
    private func clean() {
        let observers = self.observers.filter({ $0.value.value == nil })
        observers.forEach { (key, value) in
            self.observers[key] = nil
            self.handlers[key] = nil
        }
    }
    
}
