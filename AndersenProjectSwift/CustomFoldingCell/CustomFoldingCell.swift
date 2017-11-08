//
//  CustomFoldingCell.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import FoldingCell
import CoreData

class CustomFoldingCell: FoldingCell {
    
    @IBOutlet private weak var closeNumberLabel: UILabel!
    
    @IBOutlet private weak var arrivalPlace: UILabel!
    @IBOutlet private weak var departurePlace: UILabel!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var departureDateLabel: UILabel!
    
    @IBOutlet private weak var expiresLabel: UILabel!
    @IBOutlet private weak var airlineLabel: UILabel!
    @IBOutlet private weak var airlineLogoImage: UIImageView!
    @IBOutlet private weak var actionView: UIView!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var addDataLabel: UILabel!
    
    enum DateFormats: String {
        case departureDateFormat = "dd MMM yyyy HH:mm"
        case expiresDateFormat = "dd MMM yyyy"
        case addToFeatureDateFormat = "MMM d, yyyy"
    }
    
    var number: Int = 0 {
        
        didSet {
            closeNumberLabel.text = "№ " + String(number + 1)
        }
    }
    
    func getTicket(ticketResponse: TicketResponseModel, placeFullName: PlaceFullNameModel) {
        
        arrivalPlace.text = placeFullName.fullNameArrivalPlace
        departurePlace.text = placeFullName.fullNameDeparturePlace
        priceLabel.text = ticketResponse.price?.description
        airlineLabel.text = ticketResponse.airline
        addLabel.isHidden = true
        addDataLabel.isHidden = addLabel.isHidden
        
        if let expireDate = ticketResponse.expiresAt?.description {
            expiresLabel.text = expireDate.dateConfig(dateFormat: DateFormats.expiresDateFormat.rawValue)
        }
        
        if let tempDate = ticketResponse.departureAt?.description {
            departureDateLabel.text = tempDate.dateConfig(dateFormat: DateFormats.departureDateFormat.rawValue)
        }
    }
    
    private func getCurrentDate (dateFormat: String) -> String {
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let result = formatter.string(from: currentDate)
        return result
    }
    
    
    //MARK: - CoreData methods
    
    func getTicketFromCoreData(coreDataTicket: Ticket) {
        
        arrivalPlace.text = coreDataTicket.arrivalPlace
        departurePlace.text = coreDataTicket.departurePlace
        priceLabel.text = coreDataTicket.price
        airlineLabel.text = coreDataTicket.airline
        expiresLabel.text = coreDataTicket.expires
        departureDateLabel.text = coreDataTicket.departureDate
        addDataLabel.isHidden = false
        addLabel.isHidden = addDataLabel.isHidden
        addDataLabel.text = coreDataTicket.addDate
        
    }
    
    //MARK: - Actions
    
    @IBAction func addToFavoriteButtonPressed(_ sender: UIButton) {
        
        let ticketObject: Ticket = NSEntityDescription.insertNewObject(forEntityName: "Ticket", into: CoreDataManager.persistentContainer.viewContext) as! Ticket
        
        ticketObject.arrivalPlace = arrivalPlace.text
        ticketObject.departurePlace = departurePlace.text
        ticketObject.currency = currencyLabel.text
        ticketObject.price = priceLabel.text
        ticketObject.departureDate = departureDateLabel.text
        ticketObject.expires = expiresLabel.text
        ticketObject.airline = airlineLabel.text
        ticketObject.addDate = getCurrentDate(dateFormat: DateFormats.addToFeatureDateFormat.rawValue)
        
        do {
            try CoreDataManager.persistentContainer.viewContext.save()
            
        } catch {
            assertionFailure()
        }
        
        //TODO: Add airline number and logo later
        print(ticketObject)
        
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

//MARK: Date Configuration

extension String {
    
    func dateConfig (dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let tempDate = dateFormatter.date(from: self)
        
        if let tempDate = tempDate {
            
            dateFormatter.dateFormat = dateFormat
            let tempStr = dateFormatter.string(from: tempDate)
            
            return tempStr
        }
        return ""
    }
}
