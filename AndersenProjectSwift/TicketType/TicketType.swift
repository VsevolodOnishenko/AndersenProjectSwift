//
//  TicketType.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketType: BaseViewController {
    
    var ticketPlacesNavCon: UINavigationController!
    var ticketPlacesViewCon: TicketPlaces!
    
    
    let segueDirectType = "directType"
    let segueRoundType = "roundType"
    
    @IBOutlet private weak var selectLabel: UILabel!
    @IBOutlet private weak var directButton: UIButton!
    @IBOutlet private weak var roundButton: UIButton!
    
    var ticketRequestModel = TicketRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        ticketPlacesNavCon = segue.destination as? UINavigationController
        ticketPlacesViewCon = ticketPlacesNavCon.viewControllers.first as? TicketPlaces
        
        if (segue.identifier == segueDirectType) {
            ticketRequestModel.directType = true
        }
        else if (segue.identifier == segueRoundType) {
            ticketRequestModel.directType = false
        }
        ticketPlacesViewCon.ticketRequestModel = ticketRequestModel
    }
}
