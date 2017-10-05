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

//TODO: Change classes for new api

class TicketRequestModel: Mappable {
    
    let baseUrl = "http://api.travelpayouts.com/v1/prices/cheap"
    let accessToken = "074a2187e916545621a1b3aaec618272"
    
    var directType: Bool?
    
    //var country: String?
    var currency: String?
    //var locale: String?
    var originPlace: String?
    var destinationPlace: String?
    var outboundPartialDate: String?
    var inboundPartialDate: String?
    
    convenience required init?(map: Map) { 
        self.init()
    }
    
    func mapping(map: Map) {
        
        //country <- map ["country"]
        currency <- map ["currency"]
        //locale <- map ["locale"]
        originPlace <- map ["origin"]
        destinationPlace <- map ["destination"]
        outboundPartialDate <- map ["outboundDate"]
        inboundPartialDate <- map ["inboundDate"]
        
    }
    
}

extension TicketRequestModel: URLRequestConvertible {
    
    func asURLRequest() -> URLRequest { 
        
        let tempUrl = try! baseUrl.asURL()
        let urlRequest = URLRequest(url: tempUrl)
        let params: Parameters =  self.toJSON()
        
        return try! URLEncoding.default.encode(urlRequest, with: params)
        
    }
}

