//
//  TicketType.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketType: ViewController {
    
    
    @IBOutlet private weak var selectLabel: UILabel!
    @IBOutlet private weak var directButton: UIButton!
    @IBOutlet private weak var roundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let ticketPlacesNavCon = segue.destination as? UINavigationController
        let ticketPlacesViewCon = ticketPlacesNavCon?.viewControllers.first as! TicketPlaces
        
        if (segue.identifier == "directType") {
            ticketPlacesViewCon.ticketRequestModel.directType = true
        }
        if (segue.identifier == "roundType") {
            ticketPlacesViewCon.ticketRequestModel.directType = false
        }
    }
}
