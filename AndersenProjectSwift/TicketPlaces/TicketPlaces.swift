//
//  TicketPlaces.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketPlaces: ViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var originPlaceTextField: UITextField!
    @IBOutlet weak var destinationPlaceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPlaceTextField.delegate = self
        destinationPlaceTextField.delegate = self
        
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
            let alert = UIAlertController(title: "Ошибка", message: "Вы ничего не ввели.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        checkTextField(originPlaceTextField)
        checkTextField(destinationPlaceTextField)
        
        if (segue.identifier == "toTicketDates") {
            //здесь запомнить данные о введных городах и проверка на пустоту полей
        }
        
    }
    
}
