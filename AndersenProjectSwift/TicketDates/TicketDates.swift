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
    
    let ticketRequestModel = TicketRequestModel()
    let segueIdentifier = "toResultList"
    var ticketResultsViewController = TicketSearchResults()
    typealias compareDatePickerСlosure = () -> ()
    
    let dateFormat = "yyyy-MM-dd"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        departureDatePicker.setupDate() // use default values in parameters
        inboundDatePicker.setupDate(timeInterval: (60 * 60 * 24 * 180))
        inboundDatePicker.hideInboundDatePicker(ticketRequestModel: ticketRequestModel)
        hideLabel(label: dateDepartureLabel)
        
    }
    
    func hideLabel (label: UILabel) {
        
        if departureDatePicker.isHidden == true {
            label.isHidden = true
        }
    }
    
    fileprivate func createAlert(titleText: String, messageText: String) {
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkDatePicker() {
        
        let handler: compareDatePickerСlosure = { [unowned self] in
            self.createAlert(titleText: "Ошибка", messageText: "Дата отправления должна быть не позже даты возвращения")
        }
        inboundDatePicker.compareInboundDatePicker(departureDate: departureDatePicker.date, completion: handler)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        checkDatePicker()
        
        if (segue.identifier == segueIdentifier) {
            
            /*
             ticketResultsViewController = segue.destination as! TicketSearchResults
             ticketResultsViewController.ticketRequestModel.directType = ticketRequestModel.directType
             ticketResultsViewController.ticketRequestModel.originPlace = ticketRequestModel.originPlace
             ticketResultsViewController.ticketRequestModel.destinationPlace = ticketRequestModel.destinationPlace
             ticketResultsViewController.ticketRequestModel.outboundPartialDate = dateFormatter.string(from: departureDatePicker.date)
             ticketResultsViewController.ticketRequestModel.inboundPartialDate = dateFormatter.string(from: inboundDatePicker.date)
             */
            
        }
        
    }
    
    
}
