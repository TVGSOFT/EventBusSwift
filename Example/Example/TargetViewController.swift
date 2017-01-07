//
//  TargetViewController.swift
//  Example
//
//  Created by Giáp Trần on 1/7/17.
//  Copyright © 2017 Giáp Trần. All rights reserved.
//

import UIKit
import EventBusSwift

class TargetViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        EventBus.shared.register(self, name: .TargetMessage) { [weak self] (object) in
            guard let sSelf = self else { return }
            
            if let message = object as? String {
                sSelf.messageLabel.text = message
            }
            EventBus.shared.unregister(sSelf, name: .TargetMessage)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        EventBus.shared.unregister(self, name: .TargetMessage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
