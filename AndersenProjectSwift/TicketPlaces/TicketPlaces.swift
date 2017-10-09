//
//  TicketPlaces.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import Alamofire

class TicketPlaces: BaseViewController {
    
    @IBOutlet private weak var inputLabel: UILabel!
    @IBOutlet fileprivate weak var originPlaceTextField: TextField!
    @IBOutlet fileprivate weak var destinationPlaceTextField: TextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let ticketRequestModel = TicketRequestModel()
    var ticketDatesViewController = TicketDates()
    
    let segueIdentifierTicketDates = "toTicketDates"
    typealias checkTextFieldClosure = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPlaceTextField.delegate = self
        destinationPlaceTextField.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterFromKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func createAlert(titleText: String, messageText: String) {
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkInputPlaces() {
        
        let handler: checkTextFieldClosure = { [unowned self] in
            self.createAlert(titleText: "Ошибка", messageText: "Заполните все поля")
        }
        originPlaceTextField.checkTextField(spellRule: "%@",completion: handler)
        destinationPlaceTextField.checkTextField(spellRule: "%@", completion: handler)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        checkInputPlaces()
        originPlaceTextField.autocompleteTextField()
        
        if segue.identifier == segueIdentifierTicketDates {
            
            //pass data to next controller
            ticketDatesViewController = segue.destination as! TicketDates
            ticketDatesViewController.ticketRequestModel.directType = ticketRequestModel.directType
            ticketDatesViewController.ticketRequestModel.originPlace = originPlaceTextField.text
            ticketDatesViewController.ticketRequestModel.destinationPlace = destinationPlaceTextField.text
        }
    }
}






