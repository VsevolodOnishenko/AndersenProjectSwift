//
//  TicketPlaces.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import Alamofire

class TicketPlaces: ViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var inputLabel: UILabel!
    @IBOutlet fileprivate weak var originPlaceTextField: UITextField!
    @IBOutlet fileprivate weak var destinationPlaceTextField: UITextField!
    
    let ticketRequestModel = TicketRequestModel()
    var ticketDatesViewController = TicketDates()
    let segueIdentifierTicketDates = "toTicketDates"
    
    let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPlaceTextField.delegate = self
        destinationPlaceTextField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Сheck for emptiness textfield
    
    func checkTextField(_ textField: UITextField) {
        
        if textField.text == "" {
            
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func autocompleteTextField(_ textField: UITextField) {
        
        //later implement autocomplete
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        checkTextField(originPlaceTextField)
        checkTextField(destinationPlaceTextField)
        
        if segue.identifier == segueIdentifierTicketDates {
            
            //pass data to next controller
            ticketDatesViewController = segue.destination as! TicketDates
            ticketDatesViewController.ticketRequestModel.directType = ticketRequestModel.directType
            ticketDatesViewController.ticketRequestModel.originPlace = originPlaceTextField.text
            ticketDatesViewController.ticketRequestModel.destinationPlace = destinationPlaceTextField.text
        }
    }
}

// MARK: - TextFieldDelegate extension

extension TicketPlaces {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case originPlaceTextField:
            originPlaceTextField.text = textField.text
        case destinationPlaceTextField:
            destinationPlaceTextField.text = textField.text
        default:
            break
        }
    }
    
}
