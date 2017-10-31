//
//  TabBar.swift
//  AndersenProjectSwift
//
//  Created by macbook on 31.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    var flagFavoriteIsActive: Bool = false
    
    enum TabBarIndex: Int {
        
        case first = 0
        case second = 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.destination is SearchResultsTableViewController {
//           print("KEK")
//            
//        }
//        
//        switch selectedIndex {
//        case TabBarIndex.first.rawValue :
//            flagFavoriteIsActive = false
//        case TabBarIndex.second.rawValue :
//            flagFavoriteIsActive = true
//        default:
//            break
//        }
    }
}
