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
    
    @IBOutlet weak var expiresLabel: UILabel!
    @IBOutlet weak var airlineLabel: UILabel!
    @IBOutlet weak var airlineLogoImage: UIImageView!
    @IBOutlet weak var actionView: UIView!
    
    let departureDateFormat = "dd MMM yyyy HH:mm"
    let expiresDateFormat = "dd MMM yyyy"
    
    var number: Int = 0 {
        
        didSet {
            closeNumberLabel.text = "№ " + String(number + 1)
        }
    }
    
    func getTicket(ticketResponse: TicketResponseModel, placeFullName: PlaceFullNameModel) {
        
        self.arrivalPlace.text = placeFullName.fullNameArrivalPlace
        self.departurePlace.text = placeFullName.fullNameDeparturePlace
        self.priceLabel.text = ticketResponse.price?.description
        self.airlineLabel.text = ticketResponse.airline
        
        if let expireDate = ticketResponse.expiresAt?.description {
            self.expiresLabel.text = "\(dateConfig(str: expireDate, dateFormat: expiresDateFormat))"
        }
        
        if let tempDate = ticketResponse.departureAt?.description {
            self.departureDateLabel.text = "\(dateConfig(str: tempDate, dateFormat: departureDateFormat))"
        }
    }
    
    //MARK: Date Configuration
    
    private func dateConfig (str: String, dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let tempDate = dateFormatter.date(from: str)
        if let tempDate = tempDate {
            
            dateFormatter.dateFormat = dateFormat
            let tempStr = dateFormatter.string(from: tempDate)
            return tempStr
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
