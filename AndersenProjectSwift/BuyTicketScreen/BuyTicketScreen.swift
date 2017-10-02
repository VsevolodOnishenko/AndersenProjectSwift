//
//  BuyTicketScreen.swift
//  AndersenProjectSwift
//
//  Created by macbook on 01.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class BuyTicketScreen: UIViewController {

    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var buyMessageLabel: UILabel!
    
    @IBAction func crossButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        
        blurView.backgroundColor = UIColor.clear
        self.view.addSubview(blurView)
        blurView.addSubview(popUpView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
