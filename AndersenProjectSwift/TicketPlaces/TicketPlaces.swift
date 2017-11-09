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
    
    private let segueIdentifierTicketDates = "toTicketDates"
    var ticketPlaceViewModel = PlaceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originPlaceTextField.delegate = self
        destinationPlaceTextField.delegate = self
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
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if (destinationPlaceTextField.validationTextField(handler: {[unowned self] in
            self.createAlert(titleText: "Ошибка", messageText: "Заполните поля правильно")})) &&
            originPlaceTextField.validationTextField(handler: {[unowned self] in
                self.createAlert(titleText: "Ошибка", messageText: "Заполните поля правильно")}){
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueIdentifierTicketDates {
            
            ticketPlaceViewModel.ticketRequestModel.originPlace = originPlaceTextField.iataCode
            ticketPlaceViewModel.ticketRequestModel.destinationPlace = destinationPlaceTextField.iataCode
            ticketPlaceViewModel.placeFullNameModel.fullNameDeparturePlace = originPlaceTextField.text
            ticketPlaceViewModel.placeFullNameModel.fullNameArrivalPlace = destinationPlaceTextField.text
            
            guard let ticketDatesViewController = segue.destination as? TicketDates else {
                print("Error")
                return
            }
            ticketDatesViewController.ticketDateViewModel.ticketRequestModel = ticketPlaceViewModel.ticketRequestModel
            ticketDatesViewController.ticketDateViewModel.placeFullNameModel = ticketPlaceViewModel.placeFullNameModel
            
        }
    }
}






