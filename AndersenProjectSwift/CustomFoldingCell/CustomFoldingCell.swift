//
//  CustomFoldingCell.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import FoldingCell

class CustomFoldingCell: FoldingCell {
    
    @IBOutlet weak var closeNumberLabel: UILabel!
    
    @IBOutlet weak var arrivalPlace: UILabel!
    @IBOutlet weak var departurePlace: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    
    var number: Int = 0 {
        
        didSet {
            closeNumberLabel.text = "№ " + String(number + 1)
        }
    }
    
    func getTicket(ticketResponse: TicketResponseModel, ticketRequest: TicketRequestModel) {
        
        self.arrivalPlace.text = ticketRequest.destinationPlace
        self.departurePlace.text = ticketRequest.originPlace
        self.priceLabel?.text = String(describing: ticketResponse.price)
        self.departureDateLabel.text = ticketResponse.departureAt
    }
    
    //MARK: - Handler methods
    //TODO: Figure out outlets
    
    func getTicketPrice( ticketPrice: Int? ) -> String {
        
        if ticketPrice != nil {
            return String(describing: ticketPrice)
            
        }
        return ""
    }
    
    //MARK: - Nib Methods
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 15
        foregroundView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}
