//
//  CustomFoldingCell.swift
//  AndersenProjectSwift
//
//  Created by macbook on 24.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit
import FoldingCell

class CustomFoldingCell: FoldingCell {
    
    @IBOutlet weak var closeNumberLabel: UILabel!
    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = "№ " + String(number + 1)
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
}

// MARK: - Actions 

extension CustomFoldingCell {
    
    @IBAction func buttonHandler(_ sender: AnyObject) {
        print("tap")
    }
    
}
