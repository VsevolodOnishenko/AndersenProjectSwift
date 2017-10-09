//
//  BaseViewController.swift
//  AndersenProjectSwift
//
//  Created by macbook on 09.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import GooglePlaces

class BaseViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Keyboard notifications
    
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Keyboard appearence
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                
                let coeff = keyboardSize.height * 0.4
                self.view.frame.origin.y -= coeff
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                
                let coeff = keyboardSize.height * 0.4
                self.view.frame.origin.y += coeff
            }
        }
    }
}
