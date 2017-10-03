//
//  TicketPlaces.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import Alamofire

class TicketPlaces: ViewController {
    
    @IBOutlet private weak var inputLabel: UILabel!
    @IBOutlet fileprivate weak var originPlaceTextField: TextField!
    @IBOutlet fileprivate weak var destinationPlaceTextField: TextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let ticketRequestModel = TicketRequestModel()
    var ticketDatesViewController = TicketDates()
    let segueIdentifierTicketDates = "toTicketDates"
    
    var activeTextField: UITextField?
    
    let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPlaceTextField.delegate = self
        destinationPlaceTextField.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //TODO: Сделать отдельную функцию в которой будем вызывать все проверки текстовых полей
    
    //MARK: Keyboard notifications
    
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Keyboard appearence
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                
                let coeff = keyboardSize.height * 0.4  //буду двигать вью при редактировании обоих полей, так выглядит симпотичнее
                self.view.frame.origin.y -= coeff
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                
                let coeff = keyboardSize.height * 0.4
                self.view.frame.origin.y += coeff
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifierTicketDates {
            
            //pass data to next controller
            ticketDatesViewController = segue.destination as! TicketDates
            ticketDatesViewController.ticketRequestModel.directType = ticketRequestModel.directType
            ticketDatesViewController.ticketRequestModel.originPlace = originPlaceTextField.text
            ticketDatesViewController.ticketRequestModel.destinationPlace = destinationPlaceTextField.text
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
        registerForKeyboardNotifications()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}


