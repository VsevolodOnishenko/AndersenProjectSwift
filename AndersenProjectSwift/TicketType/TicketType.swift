//
//  TicketType.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketType: ViewController {
    
    @IBOutlet weak var selectLabel: UILabel!
    @IBOutlet weak var directButton: UIButton!
    @IBOutlet weak var roundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let ticketRequestModel: TicketRequestModel
        /*
        if (segue.identifier == "directType") {
            ticketRequestModel.directType = true //fix error
        }
        if (segue.identifier == "roundType") {
            ticketRequestModel.directType = false //fix error
            
        }
        */
    }
    
}
