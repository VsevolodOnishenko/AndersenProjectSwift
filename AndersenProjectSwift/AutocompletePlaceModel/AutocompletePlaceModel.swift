//
//  AutocompletePlaceModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 12.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import ObjectMapper

class AutocompletePlaceModel: Mappable {
    
    var value: String? //The 3 letter IATA location code of the given city or airport. 
                       //You can use this as an input parameter for a flight 
                       //or inspiration search.
    
    var label: String? //The name of this airport, in UTF-8 format, prefixed with
                       //the name of the city if it is not already incorporated in 
                       //the name of the airport, and appended with the location's 
                       //IATA code (as in value), enclosed in square brackets.

    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        value <- map["value"]
        label <- map["label"]
        
    }
}


