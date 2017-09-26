//
//  TicketRequestModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class TicketRequestModel: Mappable, URLRequestConvertible {
    
    var baseUrl = "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/"
    
    var directType: Bool?
    
    var country: String?
    var currency: String?
    var locale: String?
    var originPlace: String?
    var destinationPlace: String?
    var outboundPartialDate: String?
    var inboundPartialDate: String?
    
    convenience required init?(map: Map) { 
        self.init()
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
    
    func asURLRequest() -> URLRequest { //прочитать про throws
        
        let tempUrl = try! baseUrl.asURL()
        let urlRequest = URLRequest(url: tempUrl)
        let params: Parameters =  self.toJSON()
        
        return try! URLEncoding.default.encode(urlRequest, with: params)
        
    }
    
}

