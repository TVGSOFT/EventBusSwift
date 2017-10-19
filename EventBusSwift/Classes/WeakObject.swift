//
//  Weak.swift
//  EventBusSwift
//
//  Created by Giáp Trần on 10/19/17.
//

class WeakObject: NSObject {

    weak var value: AnyObject?
    
    init(value: AnyObject?) {
        self.value = value
    }
    
}
