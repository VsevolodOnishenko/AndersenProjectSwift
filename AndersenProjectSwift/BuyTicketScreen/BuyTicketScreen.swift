//
//  BuyTicketScreen.swift
//  AndersenProjectSwift
//
//  Created by macbook on 01.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class BuyTicketScreen: BaseViewController {
    
    @IBOutlet weak var buyTicketView: UIView!
    @IBOutlet weak var buyTicketMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyTicketView.layer.cornerRadius = 15.0
        buyTicketView.layer.masksToBounds = true
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
