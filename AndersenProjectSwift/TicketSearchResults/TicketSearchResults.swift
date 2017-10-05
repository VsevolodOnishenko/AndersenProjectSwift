//
//  TicketSearchResults.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketSearchResults: ViewController {
    
    
    @IBOutlet weak var ticketResultsTableView: UITableView!
    
    var ticketRequestModel = TicketRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ticketRequestModel.toJSON())//check pass data
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// TODO: Implement this 

extension TicketSearchResults: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     <#code#>
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     <#code#>
     }
     */
    
    
    
}

