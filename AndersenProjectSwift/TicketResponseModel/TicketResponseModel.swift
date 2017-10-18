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
    
    //TODO: End up with it
    
    func fetchResponse(ticketRequestModel: URLRequestConvertible) {
        
        Alamofire.request(ticketRequestModel).validate(statusCode: 200..<300).responseJSON { (response: DataResponse<Any>) in
            
            switch response.result {
            case.success:
                if let json = response.result.value {
                    print(json)
                    
                }
                
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















