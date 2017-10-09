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
    
    var baseUrl: String = "http://api.travelpayouts.com/v1/prices/cheap" //never mind
    var accessToken: String?
    var resourceFileDictionary: NSDictionary?
    
    var directType: Bool?
    
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
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            resourceFileDictionary = NSDictionary(contentsOfFile: path)
        }
        
        if let resourceFileDictionaryContent = resourceFileDictionary {
            
            resourceFileDictionaryContent.object(forKey: "baseUrl")
        }
        
        let tempUrl = try! baseUrl.asURL()
        let urlRequest = URLRequest(url: (tempUrl))
        let params: Parameters =  self.toJSON()
        
        return try! URLEncoding.default.encode(urlRequest, with: params)
        
    }
}
