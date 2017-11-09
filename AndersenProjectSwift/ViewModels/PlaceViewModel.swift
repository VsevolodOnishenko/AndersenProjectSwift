//
//  PlaceViewModel.swift
//  AndersenProjectSwift
//
//  Created by macbook on 09.11.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

final class PlaceViewModel {
    
    /*
     In future, this class can be extended
     to handle the text fields of the TicketPlaces view controller
     */
    
    var ticketRequestModel = TicketRequestModel()
    var placeFullNameModel = PlaceFullNameModel()
   
}

//MARK: - Validation

extension TextField {
    
    func validationTextField (handler: checkTextFieldClosure) -> Bool {
        
        guard self.text != nil else {
            return false
        }
        
        if (self.checkTextField(spellRule: self.isValidRule(), completion: handler)) {
            return true
        }
        return false
    }
}
