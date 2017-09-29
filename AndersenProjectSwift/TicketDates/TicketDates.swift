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
    
    let ticketRequestModel = TicketRequestModel()
    let dateFormatter = DateFormatter()
    let segueIdentifier = "toResultList"
    let dateFormat = "yyyy-MM-dd"
    var ticketResultsViewController = TicketSearchResults()
    
    let alert = UIAlertController(title: "Ошибка", message: "Дата возвращения должна быть позже даты отправления", preferredStyle: UIAlertControllerStyle.alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideInboundDatePicker(ticketRequestModel)

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
    
    func hideInboundDatePicker(_: TicketRequestModel) {
        
        if ticketRequestModel.directType == true {
            inboundDatePicker.isHidden = true
            dateInboundLabel.isHidden = true
        }
    }
    
    func checkInboundDate (inboundDate: Date, outboundDate: Date) {
        
        if outboundDate > inboundDate {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == segueIdentifier) {
            
            dateFormatter.dateFormat = dateFormat
            
            if ticketRequestModel.directType == false {
            
            checkInboundDate(inboundDate: inboundDatePicker.date, outboundDate: departureDatePicker.date)
                
            }
            
            ticketResultsViewController = segue.destination as! TicketSearchResults
            ticketResultsViewController.ticketRequestModel.directType = ticketRequestModel.directType
            ticketResultsViewController.ticketRequestModel.originPlace = ticketRequestModel.originPlace
            ticketResultsViewController.ticketRequestModel.destinationPlace = ticketRequestModel.destinationPlace
            ticketResultsViewController.ticketRequestModel.outboundPartialDate = dateFormatter.string(from: departureDatePicker.date)
            ticketResultsViewController.ticketRequestModel.inboundPartialDate = dateFormatter.string(from: inboundDatePicker.date)
            
        }
        
    }
    

}
