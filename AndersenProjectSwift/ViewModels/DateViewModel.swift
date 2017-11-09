//
//  DateViewModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 09.11.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

final class DateViewModel {
    
    /*
     In future, this class can be extended
     to handle the text fields of the TicketDates view controller
     */
    var ticketRequestModel = TicketRequestModel()
    var placeFullNameModel = PlaceFullNameModel()
    
    //FIXME: Delete this method
    
    func passTicketRequestModel() {
        
        let ticketSearchResultVC = SearchResultsTableViewController()
        ticketSearchResultVC.searchResultsViewModel.ticketRequestModel = ticketRequestModel
        ticketSearchResultVC.searchResultsViewModel.placeFullNameModel = placeFullNameModel
        
    }
}

//MARK: - Validation

extension DatePicker {
    
    func checkDatePicker(departureDate: Date, handler: compareDatePickerСlosure) -> Bool {
        
        if self.compareInboundDatePicker(departureDate: departureDate, completion: handler) {
            return true
        }
        return false
    }
}
