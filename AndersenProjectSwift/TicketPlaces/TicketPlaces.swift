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
    @IBOutlet private weak var originPlaceTextField: UITextField!
    @IBOutlet private weak var destinationPlaceTextField: UITextField!
    
    var ticketRequestModel = TicketRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPlaceTextField.delegate = self
        destinationPlaceTextField.delegate = self
        
        print(ticketRequestModel.directType?.description ?? "none") // check for pass direct or round
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TextFieldDelegate
    
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
    // MARK: - Сheck for emptiness textfield
    
    func checkTextField(_ textField: UITextField) {
        
        if textField.text == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: UIAlertControllerStyle.alert)
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
        
        //ticketRequestModel.originPlace = originPlaceTextField.text
        //ticketRequestModel.destinationPlace = destinationPlaceTextField.text
        
        if segue.identifier == "toTicketDates" {
            
            //pass data to next controller
            let ticketDatesViewController = segue.destination as! TicketDates
            ticketDatesViewController.ticketRequestModel.directType = ticketRequestModel.directType
            ticketDatesViewController.ticketRequestModel.originPlace = originPlaceTextField.text
            ticketDatesViewController.ticketRequestModel.destinationPlace = destinationPlaceTextField.text
        }
    }
}
