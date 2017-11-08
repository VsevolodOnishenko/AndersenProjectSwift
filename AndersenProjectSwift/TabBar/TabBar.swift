//
//  TabBar.swift
//  AndersenProjectSwift
//
//  Created by macbook on 31.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

final class TabBar: UITabBarController {
    
    var onSelectedSegment: ((Int) -> ())?
 
    enum TabBarIndex: Int {
        
        case first = 0
        case second = 1
    }
}
