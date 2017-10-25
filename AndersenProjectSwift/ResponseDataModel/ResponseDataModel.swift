//
//  ResponseDataModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 19.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ResponseDataModel: Mappable {
    
    var success: Bool?
    var data: [String: Any]?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        data <- map ["data"]
        success <- map ["success"]
        
    }
    
    func fetchResponse(ticketRequestModel: URLRequestConvertible, closure: (([TicketResponseModel]) -> ())?)  {
        
        Alamofire.request(ticketRequestModel).validate(statusCode: 200..<300).responseObject
            { (response: DataResponse<ResponseDataModel>) in
                
                switch response.result {
                case.success:
                    
                    if let json = response.result.value?.data?.values.first as? [String: Any] {
                        
                        var b: [TicketResponseModel] = []
                        b = json.values.flatMap{ $0 as? [String: Any] }.flatMap{ TicketResponseModel(JSON: $0) }
                        closure?(b)
                    }
                    
                case.failure:
                    
                    print("Error" + (response.debugDescription))
                    
                }
        }
    }
}
