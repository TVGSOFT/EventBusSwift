//
//  SourceViewController.swift
//  Example
//
//  Created by Giáp Trần on 1/7/17.
//  Copyright © 2017 Giáp Trần. All rights reserved.
//

import UIKit
import EventBusSwift

extension Notification.Name {
    
    public static let SourceMessage = Notification.Name("SourceMessage")
    public static let TargetMessage = Notification.Name("TargetMessage")
    
}

class SourceViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        EventBus.shared.register(self, name: .SourceMessage) { [weak self] (object) in
            guard let sSelf = self else { return }
            
            if let message = object as? String {
                sSelf.messageLabel.text = message
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        EventBus.shared.unregister(self, name: .SourceMessage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postAction(_ sender: Any) {
        EventBus.shared.post(name: .SourceMessage, object: "Hello Source View")
    }

    @IBAction func postStickyAction(_ sender: Any) {
        performSegue(withIdentifier: "TargetView", sender: nil)
        EventBus.shared.postSticky(name: .TargetMessage, object: "Hello Target View")
    }
    
}
