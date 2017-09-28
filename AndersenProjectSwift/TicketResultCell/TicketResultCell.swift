//
//  TicketResultCell.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketResultCell: UITableViewCell {
    
    @IBOutlet private weak var quoteLabel: UILabel!
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    
    @IBOutlet private weak var departureTimeLabel: UILabel!
    @IBOutlet private weak var departurePlaceLabel: UILabel!
    @IBOutlet private weak var arrivalTimeLabel: UILabel!
    @IBOutlet private weak var arrivalPlaceLabel: UILabel!
    
    @IBOutlet private weak var outPlaneIcon: UIImageView!
    @IBOutlet private weak var flyArrowIcon: UIImageView!
    @IBOutlet private weak var inPlaneIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    ///perform segue to detail description
    
}


