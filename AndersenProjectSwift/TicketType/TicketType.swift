//
//  TicketType.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketType: BaseViewController {
    
    fileprivate let segueDirectType = "directType"
    fileprivate let segueRoundType = "roundType"
    
    @IBOutlet private weak var selectLabel: UILabel!
    @IBOutlet private weak var directButton: UIButton!
    @IBOutlet private weak var roundButton: UIButton!
    
    var ticketRequestModel = TicketRequestModel()
    
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
            case segueDirectType:
                ticketRequestModel.directType = true
            case segueRoundType:
                ticketRequestModel.directType = false
            default:
                break
            }
            
        }
        ticketPlacesViewController.ticketRequestModel = ticketRequestModel
    }
}
