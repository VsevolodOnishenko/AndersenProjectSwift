//
//  DataPicker.swift
//  AndersenProjectSwift
//
//  Created by macbook on 01.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

final class DatePicker: UIDatePicker {
    
    typealias compareDatePickerСlosure = () -> ()
    
    convenience init() {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: DatePicker Methods
    
    func setupDate(minDate: Date = Date(), timeInterval: TimeInterval = (60 * 60 * 24 * 90)) {
        
        self.minimumDate = minDate
        self.maximumDate = minDate.addingTimeInterval(timeInterval)
    }
    
    func compareInboundDatePicker (departureDate: Date, completion: compareDatePickerСlosure) {
        
        if departureDate > self.date {
            completion()
        }
    }
    
    func hideInboundDatePicker(ticketRequestModel: TicketRequestModel) {
        
        if ticketRequestModel.directType == true {
            self.isHidden = true
        }
    }
    
    func convertDateToString(dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let stringDate = dateFormatter.string(from: self.date)
        return stringDate 
    }
}
