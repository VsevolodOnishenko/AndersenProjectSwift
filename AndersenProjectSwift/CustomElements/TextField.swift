//
//  TextField.swift
//  AndersenProjectSwift
//
//  Created by macbook on 03.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

protocol TextFieldProtocol {
    func checkTextField(_ textField: TextField)
    func autocompleteTextField(_ textField: TextField)
}

class TextField: UITextField {
    
}

// MARK: TextFieldProtocol

extension TextField: TextFieldProtocol {
    
    func autocompleteTextField(_ textField: TextField) {
        //add some actions later
    }
    
    func checkTextField(_ textField: TextField) {
        
        if textField.text == "" {
            
        }
    }
    
}
