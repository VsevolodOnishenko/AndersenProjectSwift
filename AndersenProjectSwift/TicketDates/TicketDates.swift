//
//  TicketDates.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketDates: ViewController {
    
    @IBOutlet private weak var dateDepartureLabel: UILabel!
    @IBOutlet private weak var departureDatePicker: DatePicker!
    @IBOutlet private weak var dateInboundLabel: UILabel!
    @IBOutlet private weak var inboundDatePicker: DatePicker!
    @IBOutlet private weak var searchButton: UIButton!
    
    let ticketRequestModel = TicketRequestModel()
    let segueIdentifier = "toResultList"
    var ticketResultsViewController = TicketSearchResults()
    
    let dateFormat = "yyyy-MM-dd"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let minDate = Date()
        let departureTimeInterval: TimeInterval = (60 * 60 * 24 * 90) //90 days from today
        let inboundTimeInterval: TimeInterval = (60 * 60 * 24 * 180) //180 days from today
        
        //setup datepickers on view
        departureDatePicker.setupDate(minDate: minDate, timeInterval: departureTimeInterval)
        inboundDatePicker.setupDate(minDate: minDate, timeInterval: inboundTimeInterval)
        inboundDatePicker.hideInboundDatePicker(ticketRequestModel: ticketRequestModel, label: dateInboundLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAlert(titleText: String, messageText: String) {
        
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkDatePicker() {
        
        let handler: () -> () = {
            self.createAlert(titleText: "Ошибка", messageText: "Дата отправления должна быть не позже даты возвращения")
        }
        inboundDatePicker.compareDatePickers(departureDate: departureDatePicker.date, completion: handler)
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
