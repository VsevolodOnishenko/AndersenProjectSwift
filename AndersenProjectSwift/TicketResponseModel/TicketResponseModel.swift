//
//  TicketResponseModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class TicketResponseModel: Mappable {
    
    var price: Int?
    var airline: String?
    var flightNumber: Int?
    var departureAt: String?
    var returnAt: String?
    var expiresAt: String? // relevance of information
    
    convenience required init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        
        price <- map ["price"]
        airline <- map ["airline"]
        flightNumber <- map ["flightNumber"]
        departureAt <- map ["departureAt"]
        returnAt <- map ["returnAt"]
        expiresAt <- map ["expiresAt"]
        
    }
    
}















