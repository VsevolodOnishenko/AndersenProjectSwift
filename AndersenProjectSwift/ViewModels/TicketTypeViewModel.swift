//
//  TicketTypeViewModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 09.11.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketTypeViewModel {
    
    var ticketRequestModel = TicketRequestModel()
    
    private enum SegueType: String {
        case segueDirectType = "directType"
        case segueRoundType = "roundType"
    }
    
    func passTicketRequestModel(segueIdentifier: String) -> TicketRequestModel {
        
        switch segueIdentifier {
        case SegueType.segueDirectType.rawValue:
            ticketRequestModel.directType = true
        case SegueType.segueRoundType.rawValue:
            ticketRequestModel.directType = false
        default:
            break
        }
        return ticketRequestModel
        
    }
}
