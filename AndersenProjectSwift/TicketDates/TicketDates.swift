//
//  TicketDates.swift
//  AndersenProjectSwift
//
//  Created by macbook on 26.09.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TicketDates: ViewController {

    @IBOutlet weak var dateDepartureLabel: UILabel!
    
    @IBOutlet weak var departureDatePicker: UIDatePicker!
    
    @IBOutlet weak var dateInboundLabel: UILabel!
    
    @IBOutlet weak var inboundDatePicker: UIDatePicker!
    
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toResultList") {
            //запоминаем даты, пока что оставил константы
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            
            let departureDate = dateFormatter.string(from: departureDatePicker.date)
            let inboundDate = dateFormatter.string(from: inboundDatePicker.date)
            print((departureDate), "\n", (inboundDate))
            
        }
        
    }
    

}
