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
        
        let handler: checkTextFieldClosure = { [unowned self] in
            self.createAlert(titleText: "Ошибка", messageText: "Заполните все поля")
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterFromKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }
    
    // MARK: - Navigation
    
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






