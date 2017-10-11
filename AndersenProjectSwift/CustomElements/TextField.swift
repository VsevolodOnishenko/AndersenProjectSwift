//
//  TextField.swift
//  AndersenProjectSwift
//
//  Created by macbook on 03.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import Alamofire

class TextField:  AutoCompleteTextField {
    
    private var responseData:NSMutableData?
    private var dataTask:URLSessionDataTask?
    
    private let url = "https://api.sandbox.amadeus.com/v1.2/airports/autocomplete"
    private let apiKey = "Y7AFRIgeJIAc6ccGtLkHQJ7reXqlLuYh"
    
    typealias checkTextFieldClosure = () -> ()
    
    //MARK: - Check Validation 
    
    func checkTextField(spellRule: (String) -> (Bool), completion: checkTextFieldClosure) {
        
        if spellRule(self.text!) {
            completion()
        }
    }
    
    //MARK: - Rules
    
    func isEmptyRule(textField: String) -> Bool {
        return textField.isEmpty
    }
    
    func isValidRule(textField: String) -> Bool {
        
        let validSet = NSCharacterSet.decimalDigits.inverted
        let range = textField.rangeOfCharacter(from: validSet)
        
        if range != nil {
            return false
        } else {
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
    
    func handleTextFieldInterfaces() {
        
        self.onTextChange = {/*[weak self]*/ text in
            if !(self.text?.isEmpty)! {
                if let dataTask = self.dataTask {
                    dataTask.cancel()
                }
                self.fetchAutocompletePlaces(text)
            }
        }
        
        /*
         self.onSelect = {[weak self] text, indexpath in
         
         }
         */
    }
    
    fileprivate func fetchAutocompletePlaces(_ keyword:String) {
        
        let urlString = "\(url)?apikey=\(apiKey)&term=\(keyword)"
        let s = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
        s.addCharacters(in: "+&")
        if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: s as CharacterSet) {
            if let url = URL(string: encodedString) {
                let request = URLRequest(url: url)
                dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                    if let data = data {
                        
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                            
                            print(result)
                            
                            if let status = result["status"] as? String{
                                if status == "success"{
                                    if let predictions = result["predictions"] as? NSArray{
                                        var locations = [String]()
                                        for dict in predictions as! [NSDictionary]{
                                            locations.append(dict["description"] as! String)
                                        }
                                        DispatchQueue.main.async(execute: { () -> Void in
                                            self.autoCompleteStrings = locations
                                        })
                                        return
                                    }
                                }
                            }
                            DispatchQueue.main.async(execute: { () -> Void in
                                self.autoCompleteStrings = nil
                            })
                        }
                        catch let error as NSError{
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                })
                dataTask?.resume()
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
