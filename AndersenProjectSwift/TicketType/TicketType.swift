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
    
    let ticketTypeViewModel = TicketTypeViewModel()
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let ticketPlacesViewController = segue.destination as? TicketPlaces else {
            print("Error")
            return
        }
        
        if let segueIdentifier = segue.identifier {
            ticketPlacesViewController.ticketPlaceViewModel.ticketRequestModel = ticketTypeViewModel.passTicketRequestModel(segueIdentifier: segueIdentifier)
            
        }
    }
}
