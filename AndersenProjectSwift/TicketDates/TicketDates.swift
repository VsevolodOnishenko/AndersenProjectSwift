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
    
    var ticketRequestModel = TicketRequestModel()
    private let segueIdentifier = "toResultList"
    
    typealias compareDatePickerСlosure = () -> ()
    private let departureMaxTimeInterval: TimeInterval = (60 * 60 * 24 * 180)
    private let dateFormat = "yyyy-MM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        departureDatePicker.setupDate() //use default values in parameters
        inboundDatePicker.setupDate(timeInterval: departureMaxTimeInterval)
        inboundDatePicker.hideInboundDatePicker(ticketRequestModel: ticketRequestModel)
        inboundDatePicker.isHidden = dateInboundLabel.isHidden
        
    }
    
    fileprivate func checkDatePicker(d: DatePicker) -> Bool {
        
        let handler: compareDatePickerСlosure = { [unowned self] in
            self.createAlert(titleText: "Ошибка", messageText: "Дата отправления должна быть не позже даты возвращения")
        }
        
        if d.compareInboundDatePicker(departureDate: departureDatePicker.date, completion: handler) {
            return true
        }
        return false
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if checkDatePicker(d: inboundDatePicker) {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == segueIdentifier) {
            
            ticketRequestModel.departDate = departureDatePicker.convertDateToString(dateFormat: dateFormat)
            ticketRequestModel.returnDate = inboundDatePicker.convertDateToString(dateFormat: dateFormat)
            
            guard let ticketResultsViewController = segue.destination as? TicketSearchResults else {
                print("Error")
                return
            }
            ticketResultsViewController.ticketRequestModel = ticketRequestModel
        }
    }
}
