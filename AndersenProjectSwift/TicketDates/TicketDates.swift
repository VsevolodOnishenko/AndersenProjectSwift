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
    
    @IBOutlet private weak var departureDatePicker: UIDatePicker!
    
    @IBOutlet private weak var dateInboundLabel: UILabel!
    
    @IBOutlet private weak var inboundDatePicker: UIDatePicker!
    
    @IBOutlet private weak var searchButton: UIButton!
    
    var ticketRequestModel = TicketRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        departureDatePicker.minimumDate = Date() //Today's date
        departureDatePicker.maximumDate = Date().addingTimeInterval(60 * 60 * 24 * 90)
        inboundDatePicker.minimumDate = Date()
        inboundDatePicker.maximumDate = Date().addingTimeInterval(60 * 60 * 24 * 180)
        
        print(ticketRequestModel.directType?.description ?? "none") // check for pass data
        print(ticketRequestModel.originPlace!)
        print(ticketRequestModel.destinationPlace!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toResultList") {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let ticketResultsViewController = segue.destination as! TicketSearchResults
            ticketResultsViewController.ticketRequestModel.directType = ticketRequestModel.directType
            ticketResultsViewController.ticketRequestModel.originPlace = ticketRequestModel.originPlace
            ticketResultsViewController.ticketRequestModel.destinationPlace = ticketRequestModel.destinationPlace
            ticketResultsViewController.ticketRequestModel.outboundPartialDate = dateFormatter.string(from: departureDatePicker.date)
            ticketResultsViewController.ticketRequestModel.inboundPartialDate = dateFormatter.string(from: inboundDatePicker.date)
            
        }
        
    }
    

}
