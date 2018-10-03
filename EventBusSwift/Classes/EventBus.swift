//
//  EventBus.swift
//  Model
//
//  Created by Giáp Trần on 9/16/16.
//  Copyright © 2016 TVG Soft, Inc. All rights reserved.
//

public typealias EventBusHandler = (Any?) -> Void

public class EventBus {
    
    // MARK: Property
    
    public static let shared = EventBus()
    
    private var subscribers = [String: EventPost]()
    
    private var stickyTimer: Timer?
    
    /*
     * Limit postSticky run below 10 times, it will stop.
     */
    private let limitSticky: Float = 2.0
    private var timeCounter: Float = 0.0
    
    // MARK: Constructor
    
    private init() {
    }
    
    // MARK: Public method
    
    public func post(name aName: Notification.Name, object: Any?) {
        if let eventPost = subscribers[aName.rawValue] {
            eventPost.object = object
            eventPost.isActive = true
        }
        NotificationCenter.default.post(name: aName, object: object)
    }
    
    public func postSticky(name aName: Notification.Name, object: Any?) {
        if let eventPost = subscribers[aName.rawValue] {
            eventPost.object = object
            eventPost.isActive = true
        } else {
            let eventPost = EventPost()
            eventPost.object = object
            eventPost.isActive = true
            
            subscribers[aName.rawValue] = eventPost
        }
        startSchedulePost()
    }
    
    public func register(_ observer: AnyObject, name: Notification.Name, handler: @escaping EventBusHandler) {
        var eventPost = subscribers[name.rawValue]
        if eventPost == nil {
            eventPost = EventPost()
            subscribers[name.rawValue] = eventPost
        }
        if eventPost!.isEmpty {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(receiveNotification(_:)),
                name    : name,
                object  : nil
            )
        }
        eventPost?.add(observer: observer, handler: handler)
    }
    
    public func unregister(_ observer: AnyObject, name: Notification.Name) {
        if let eventPost = subscribers[name.rawValue] {
            eventPost.remove(observer: observer)
            if eventPost.isEmpty {
                NotificationCenter.default.removeObserver(self, name: name, object: nil)
                subscribers[name.rawValue] = nil
            }
        }
    }
    
    // MARK: Private method
    
    @objc
    private func memmoryWarningNotification(_ notification: Notification) {
        NotificationCenter.default.removeObserver(self)
        subscribers.removeAll()
    }
    
    @objc
    private func receiveNotification(_ notification: Notification) {
        let name = notification.name.rawValue
       
        sendData(name: name)
    }
    
    private func sendData(name: String) {
        if let eventPost = subscribers[name], !eventPost.isEmpty {
            stopSchedulePost()
            
            eventPost.send()
            eventPost.object = nil
            eventPost.isActive = false
        }
    }
    
    private func startSchedulePost() {
        stickyTimer = Timer.scheduledTimer(
            timeInterval: 0.2,
            target      : self,
            selector    : #selector(stickyRunning),
            userInfo    : nil,
            repeats     : true
        )
    }
    
    private func stopSchedulePost() {
        timeCounter = 0
        
        stickyTimer?.invalidate()
        stickyTimer = nil
    }
    
    @objc
    private func stickyRunning() {
        if !subscribers.isEmpty {
            let postSubribers = subscribers.filter() { (name, eventPost) -> Bool in
                return eventPost.isActive
            }
            if timeCounter > limitSticky {
                for (_, eventPost) in postSubribers {
                    eventPost.object = nil
                    eventPost.isActive = false
                }
                stopSchedulePost()
                return
            }
            for (name, _) in postSubribers {
                sendData(name: name)
            }
            timeCounter += 0.2
        }
    }
    
}
