//
//  TicketRequestModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import ObjectMapper
import Alamofire

class TicketRequestModel: Mappable {
    
    var directType: Bool?
    var accessToken: String?
    
    var originPlace: String?
    var destinationPlace: String?
    var departDate: String?
    var returnDate: String?
    var currency: String?
    
    enum TicketRequestModelError: Error {
        
        case invalid
        case nothingInPlist
        
    }
    
    convenience required init?(map: Map) {
        self.init()
        
    }
    
    func mapping(map: Map) {
        
        currency <- map ["currency"]
        originPlace <- map ["origin"]
        destinationPlace <- map ["destination"]
        departDate <- map ["depart_date"]
        returnDate <- map ["return_date"]
        
    }
}

extension TicketRequestModel: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        
        var dictRoot: NSDictionary?
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            dictRoot = NSDictionary(contentsOfFile: path)
        }
        
        guard let dict = dictRoot else {
            throw TicketRequestModelError.nothingInPlist
        }
        
        guard let baseUrl = (dict["baseUrl"] as? String),
            let accessToken = (dict["accessToken"] as? String) else {
                throw TicketRequestModelError.nothingInPlist
        }
        
        print("baseUrl \(baseUrl)")
        print("accessToken \(accessToken)")
        
        let url = try baseUrl.asURL()
        let urlRequest = URLRequest(url: url)
        var params: Parameters =  self.toJSON()
        params["accessToken"] = accessToken
        
        print("\n", params)
        return try URLEncoding.default.encode(urlRequest, with: params)
        
    }
}
