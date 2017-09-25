//
//  TicketRequestModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class TicketRequestModel:  Mappable {
    
    var country: String?
    var currency: String?
    var locale: String?
    var originPlace: String?
    var destinationPlace: String?
    var outboundPartialDate: String?
    var inboundPartialDate: String?
    
    init() {
        
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        country <- map ["country"]
        currency <- map ["currency"]
        locale <- map ["locale"]
        originPlace <- map ["originPlace"]
        destinationPlace <- map ["destinationPlace"]
        outboundPartialDate <- map ["outboundDate"]
        inboundPartialDate <- map ["inboundDate"]
        
        }
    }


