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

//TODO: Change classes for new api

class TicketResponseModel: Mappable {
    
    var success: Bool?
    var data: [String: Any]?
    
    var id: Int?
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
        
       data <- map ["data"]
       success <- map ["success"]
        
    }
    
    func fetchResponse(ticketRequestModel: URLRequestConvertible) {
        
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
    /*
    func getTickets(HKT: String) -> [TicketType] {
       return nil
    }*/
}















