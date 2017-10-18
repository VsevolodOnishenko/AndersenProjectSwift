//
//  TextField.swift
//  AndersenProjectSwift
//
//  Created by macbook on 03.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import Alamofire

class TextField: AutoCompleteTextField {
    
    
    var iataCode: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fetchAutocompleteResponse()
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
        
        if trimNumbers.isEmpty
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
    
    func fetchAutocompleteResponse() {
        
        var arrayValues: Array<String> = [] // for IATA codes
        
        self.onTextChange = { [weak self] string in
            
            let autocompletePlaceModelRequest = AutocompletePlaceRequestModel(str: string)
            let request = Alamofire.request(autocompletePlaceModelRequest)
            
            request.validate().responseArray
                { (response: DataResponse<[AutocompletePlaceModel]>) in
                    
                    switch response.result {
                    case.success:
                        let autocompletePlaceModel = response.result.value
                        guard let autocompletePlace = autocompletePlaceModel else {
                            return
                        }
                        var arrayPlaces: Array<String> = []
                        for place in autocompletePlace {
                            if let placeLabel = place.label, let placeValue = place.value {
                                arrayPlaces.append(placeLabel)
                                arrayValues.append(placeValue)
                            }
                        }
                        self?.autoCompleteStrings = arrayPlaces
                        
                    case.failure:
                        print("Error" + (response.debugDescription))
                        request.cancel()
                    }
                    
            }
            
        }
        
        self.onSelect = {[weak self] string, indexpath in
            
            guard let array = self?.autoCompleteStrings else {
                return
            }
            for i in array {
                if self?.text == i {
                    guard let index = array.index(of: i) else {
                        return
                    }
                    self?.iataCode = arrayValues[index]
                    print(arrayValues[index])
                }
                
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
