//
//  AutocompletePlaceRequestModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 13.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import Alamofire

class AutocompletePlaceRequestModel {
    
    var inputUser: String?
    
    init(str: String?) {
        self.inputUser = str
    }
    
    enum AutocompleteRequestModelError: Error {
        
        case invalid
        case errorInput
        case nothingInPlist
    }
}

extension AutocompletePlaceRequestModel: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        
        var dictRoot: NSDictionary?
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            dictRoot = NSDictionary(contentsOfFile: path)
        }
        
        guard let autocompleteBaseUrl = (dictRoot?["autocompleteBaseUrl"] as? String),
            let autocompleteApiKey = (dictRoot?["autocompleteApiKey"] as? String) else {
                throw AutocompleteRequestModelError.nothingInPlist
        }
        
        print("autocompleteBaseUrl \(autocompleteBaseUrl)")
        print("autocompleteApiKey \(autocompleteApiKey)")
        
        guard let inputUser = inputUser else {
            throw AutocompleteRequestModelError.invalid
        }
        
        let url = try autocompleteBaseUrl.asURL()
        let urlRequest = URLRequest(url: (url))
        let params: Parameters =  [
            "apikey" : autocompleteApiKey,
            "term" : inputUser
        ]
        
        print(urlRequest)
        print(inputUser)
        return try URLEncoding.default.encode(urlRequest, with: params)
    }
}

