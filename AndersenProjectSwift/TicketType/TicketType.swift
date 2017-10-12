//
//  TicketType.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketType: BaseViewController {
    
    @IBOutlet private weak var selectLabel: UILabel!
    @IBOutlet private weak var directButton: UIButton!
    @IBOutlet private weak var roundButton: UIButton!
    
    var ticketRequestModel = TicketRequestModel()
    
    private enum SegueType: String {
        case segueDirectType = "directType"
        case segueRoundType = "roundType"
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let ticketPlacesNavigationController = segue.destination as? UINavigationController
            else {
                print("Error")
                return
        }
        
        guard let ticketPlacesViewController = ticketPlacesNavigationController.topViewController as? TicketPlaces else {
            print("Error")
            return
        }
        
        if let segueIdentifier = segue.identifier {
            
            switch segueIdentifier {
            case SegueType.segueDirectType.rawValue:
                ticketRequestModel.directType = true
            case SegueType.segueRoundType.rawValue:
                ticketRequestModel.directType = false
            default:
                break
            }
            
        }
        ticketPlacesViewController.ticketRequestModel = ticketRequestModel
    }
}
