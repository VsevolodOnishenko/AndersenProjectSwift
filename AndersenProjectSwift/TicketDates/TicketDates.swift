//
//  TicketDates.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketDates: BaseViewController {
    
    @IBOutlet private weak var dateDepartureLabel: UILabel!
    @IBOutlet private weak var departureDatePicker: DatePicker!
    @IBOutlet private weak var dateInboundLabel: UILabel!
    @IBOutlet private weak var inboundDatePicker: DatePicker!
    @IBOutlet private weak var searchButton: UIButton!
    
    var ticketDateViewModel = DateViewModel()
    private let segueIdentifier = "toResultTable"
    private let departureMaxTimeInterval: TimeInterval = (60 * 60 * 24 * 180)
    private let dateFormat = "yyyy-MM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePickers()
        searchButton.layer.cornerRadius = 15
    }
    
    private func setupDatePickers() {
        
        departureDatePicker.setupDate()
        inboundDatePicker.setupDate(timeInterval: departureMaxTimeInterval)
        inboundDatePicker.hideInboundDatePicker(ticketRequestModel: ticketDateViewModel.ticketRequestModel)
        dateInboundLabel.isHidden = inboundDatePicker.isHidden
        
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if inboundDatePicker.compareInboundDatePicker(departureDate: departureDatePicker.date, completion: { [unowned self] in
            self.createAlert(titleText: "Ошибка", messageText: "Дата отправления должна быть не позже даты возвращения")
        }) {
            return true
        }
        return false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == segueIdentifier) {
            
            ticketDateViewModel.ticketRequestModel.departDate = departureDatePicker.convertDateToString(dateFormat: dateFormat)
            ticketDateViewModel.ticketRequestModel.returnDate = inboundDatePicker.convertDateToString(dateFormat: dateFormat)
            ticketDateViewModel.passTicketRequestModel()
            
        }
    }
}
