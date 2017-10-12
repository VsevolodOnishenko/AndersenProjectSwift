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
    @IBOutlet private weak var originPlaceTextField: TextField!
    @IBOutlet private weak var destinationPlaceTextField: TextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var responseData:NSMutableData?
    private var dataTask:URLSessionDataTask?
    
    var ticketRequestModel = TicketRequestModel()
    
    private let segueIdentifierTicketDates = "toTicketDates"
    
    typealias checkTextFieldClosure = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPlaceTextField.delegate = self
        destinationPlaceTextField.delegate = self
        
        //for autocompelete
        originPlaceTextField.configureTextField()
        destinationPlaceTextField.configureTextField()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterFromKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }
    
    func validationTextField(s: TextField) -> Bool {
        
        let handler: checkTextFieldClosure = { [unowned self] in
            self.createAlert(titleText: "Ошибка", messageText: "Заполните поля правильно")
        }
        
        guard s.text != nil else {
            return false
        }
        
        if (s.checkTextField(spellRule: s.isValidRule(), completion: handler)) {
            return true
        }
        return false
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if (validationTextField(s: destinationPlaceTextField) &&
            validationTextField(s: originPlaceTextField)) {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifierTicketDates {
            
            ticketRequestModel.originPlace = originPlaceTextField.text
            ticketRequestModel.destinationPlace = destinationPlaceTextField.text
            
            guard let ticketDatesViewController = segue.destination as? TicketDates else {
                print("Error")
                return
            }
            ticketDatesViewController.ticketRequestModel = ticketRequestModel
        }
    }
}






