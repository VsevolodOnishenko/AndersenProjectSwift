//
//  BuyTicketScreen.swift
//  AndersenProjectSwift
//
//  Created by macbook on 01.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class BuyTicketScreen: UIViewController {

    @IBOutlet weak var buyTicketView: UIView!
    @IBOutlet weak var buyTicketMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyTicketView.layer.cornerRadius = 15.0
        buyTicketView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
