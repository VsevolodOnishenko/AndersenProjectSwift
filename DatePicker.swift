//
//  DataPicker.swift
//  AndersenProjectSwift
//
//  Created by macbook on 01.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

final class DatePicker: UIDatePicker {
    
    var dateFormatter: DateFormatter?
    
    convenience init() {
        self.init()
        self.dateFormatter = DateFormatter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: DatePicker Methods
    
    func setupDate(minDate: Date, timeInterval: TimeInterval) {
        
        self.minimumDate = minDate
        self.maximumDate = minDate.addingTimeInterval(timeInterval)
    }
    
    func compareDatePickers (departureDate: Date, completion: () -> ()) {
        
        if departureDate > self.date {
            completion()
        }
    }
    
    func hideInboundDatePicker(ticketRequestModel: TicketRequestModel, label: UILabel) {
        
        if ticketRequestModel.directType == true {
            self.isHidden = true
            label.isHidden = true
        }
    }
    
    func convertDateToString(dateFormat: String) -> String {
        
        self.dateFormatter?.dateFormat = dateFormat
        let stringDate = dateFormatter?.string(from: self.date)
        return stringDate!
    }
}
