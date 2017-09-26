//
//  TicketResponseModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class TicketResponseModel: Mappable {
    
    var quotedId: Int?
    
    var minPrice: Int?
    var currency: String?
    
    var originPlace: String?
    var originPlaceId: Int?
    var originCarrier: String?
    var originCarrierId: String?
    
    var destinationPlace: String?
    var destinationPlaceId: Int?
    var destinationCarrier: String?
    var destinationCarrierId: Int?
    
    var outboundDepartureDate: String?
    var inboundDepartureDate: String?
    
    
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        quotedId <- map ["Quotes.QuoteId"]
        
        minPrice <- map ["Quotes.MinPrice"]
        currency <- map ["Currencies.Code"]
        
        originPlace <- map ["Places.Name"]
        originPlaceId <- map ["Quotes.OutboundLeg.OriginId"]
        originCarrier <- map ["Carriers.Name"]
        originCarrierId <- map ["Quotes.OutboundLeg.CarrierIds"]
        
        destinationPlace <- map ["Places.Name"]
        destinationPlaceId <- map ["Quotes.OutboundLeg.DestinationId"]
        destinationCarrier <- map ["Carrier.Name"]
        destinationCarrierId <- map ["Quotes.OutboundLeg.CarrierIds"]
        
        outboundDepartureDate <- map ["Quotes.OutboundLeg.DepartureDate"]
        inboundDepartureDate <- map ["Quotes.InboundLeg.DepartureDate"]
    }
    
    func fetchResponse(ticketRequestModel: URLRequestConvertible) {
        
        // UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(ticketRequestModel).validate(statusCode: [200]).responseObject { (response: DataResponse<TicketResponseModel>) in
            
            switch response.result {
            case.success:
                let ticketResponse = response.result.value
                print("Some Info")
                print(ticketResponse!)
            case.failure:
                print("Error" + (response.debugDescription))
            }
        }
    }
    
}















