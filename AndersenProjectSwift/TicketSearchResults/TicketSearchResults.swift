//
//  TicketSearchResults.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketSearchResults: BaseViewController {
    
    @IBOutlet fileprivate weak var ticketResultsTableView: UITableView!
    var ticketRequestModel = TicketRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ticketRequestModel.toJSON())//check pass data
        
    }
}

// TODO: Implement this

extension TicketSearchResults: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //count of tickets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ticketResultsTableView.dequeueReusableCell(withIdentifier: "ticketResultCell", for: indexPath)
        
        return cell
    }
}

