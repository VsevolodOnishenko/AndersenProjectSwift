//
//  TextField.swift
//  AndersenProjectSwift
//
//  Created by macbook on 03.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import Alamofire

class TextField: UITextField {
    
    typealias checkTextFieldClosure = () -> ()
    
    func autocompleteTextField() {
        
        let url = "https://api.sandbox.amadeus.com/v1.2/airports/autocomplete"
        let textFieldText = self.text
        
        let parameters: [String: String] = [
            "apikey" : "Y7AFRIgeJIAc6ccGtLkHQJ7reXqlLuYh",
            "term": (textFieldText) ?? ""
        ]
        
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString)).responseJSON { response in
                            print("Request: \(String(describing: response.request))")   // original url request
                            print("Response: \(String(describing: response.response))") // http url response
                            print("Result: \(response.result)")                         // response serialization result
                            
                            if let json = response.result.value {
                                print("JSON: \(json)") // serialized json response
                            }
                            
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("Data: \(utf8Text)") // original server data as UTF8 string
                            }
        }
    }
    
    func checkTextField(spellRule: String, completion: checkTextFieldClosure) {
        
        if self.text != spellRule {
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
