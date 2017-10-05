//
//  TextField.swift
//  AndersenProjectSwift
//
//  Created by macbook on 03.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    func autocompleteTextField(_ textField: TextField) {
        //add some actions later
    }
    
    // TODO: Fix this with rule in closure
    
    func checkTextField(completion: () -> ()) {
        
        if self.text == "" {
            completion()
        }
    }
    
}

// MARK: - TextFieldDelegate

extension TicketPlaces: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
