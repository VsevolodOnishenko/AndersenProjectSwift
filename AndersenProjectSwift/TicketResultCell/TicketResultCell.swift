//
//  TicketResultCell.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketResultCell: UITableViewCell {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var departurePlaceLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var arrivalPlaceLabel: UILabel!
    
    @IBOutlet weak var outPlaneIcon: UIImageView!
    @IBOutlet weak var flyArrowIcon: UIImageView!
    @IBOutlet weak var inPlaneIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
