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

class TicketRequestModel: Mappable {
    
    var directType: Bool?
    
    let baseUrl = "kek"
    
    var originPlace: String?
    var destinationPlace: String?
    var departDate: String?
    var returnDate: String?
    var currency: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        currency <- map ["currency"]
        originPlace <- map ["origin"]
        destinationPlace <- map ["destination"]
        departDate <- map ["outboundDate"]
        returnDate <- map ["inboundDate"]
        
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

