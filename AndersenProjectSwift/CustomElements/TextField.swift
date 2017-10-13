//
//  TextField.swift
//  AndersenProjectSwift
//
//  Created by macbook on 03.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator

class TextField:  AutoCompleteTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.onTextChange = { [weak self] string in
            self?.autoCompleteStrings = ["String","2","Los Angeles"]
            
            /*
            let autocompletePlaceModelRequest = AutocompletePlaceRequestModel(str: string)
            Alamofire.request(autocompletePlaceModelRequest).validate().responseObject { (response: DataResponse<AutocompletePlaceModel>) in
                
                switch response.result {
                case.success:
                    
                    let autocompletePlaceModel = response.result
                    print("Some Info")
                    print(autocompletePlaceModel)
                    self?.autoCompleteStrings = ["1","2","3"]
                case.failure:
                    print("Error" + (response.debugDescription))
                }
            }
            */
            
        }
        /*
         self.onSelect = {
         
         }*/

    }
    
    typealias checkTextFieldClosure = () -> ()
    
    //MARK: - Check Validation
    
    func checkTextField(spellRule: Bool, completion: checkTextFieldClosure) -> Bool {
        
        if spellRule {       //если сюда приходит тру, тогда вызываем комплижн
            completion()     //пример: isEmpty = true, тогда spellRule = true, тогда комплижн
            return false
        }
        return true
    }
    
    //MARK: - Rules
    
    func isEmptyRule() -> Bool {
        
        guard let text = self.text else {
            return true
        }
        print(text.isEmpty)
        return text.isEmpty
    }
    
    func isValidRule() -> Bool {
        
        guard let text = self.text else {
            return true
        }
        
        let invertedNumbersValidSet = NSCharacterSet.decimalDigits.inverted
        
        let trimNumbers = text.trimmingCharacters(in: invertedNumbersValidSet)
        let trimWhiteSpaces = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("\n ", trimNumbers, "\n", trimWhiteSpaces.characters)
        
        if trimNumbers.characters.count == 0
            && trimWhiteSpaces.characters.count > 0 {
            
            print("False")
            return false
            
        } else {
            print("true")
            return true
        }
    }
    
    // MARK: - Autocomplete Methods
    
    func configureTextField() {
        
        self.autoCompleteTextColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        self.autoCompleteTextFont = UIFont(name: "HelveticaNeue-Light", size: 12.0)!
        self.autoCompleteCellHeight = 35.0
        self.maximumAutoCompleteCount = 20
        self.hidesWhenSelected = true
        self.hidesWhenEmpty = true
        self.enableAttributedText = true
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIColor.black
        attributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        self.autoCompleteAttributes = attributes
    }
    
    
    func fetchAutocompletePlaces(autocompletePlaceModelRequest: URLRequestConvertible) {
        
        Alamofire.request(autocompletePlaceModelRequest).validate().responseObject { (response: DataResponse<AutocompletePlaceModel>) in
            
            NetworkActivityIndicatorManager.shared.isEnabled = true
            NetworkActivityIndicatorManager.shared.startDelay = 2.0
            
            switch response.result {
            case.success:
                let autocomplete = response.result.value
                print("Some Info")
                print(autocomplete!)
            case.failure:
                print("Error" + (response.debugDescription))
            }
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
