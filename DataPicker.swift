//
//  DataPicker.swift
//  AndersenProjectSwift
//
//  Created by macbook on 01.10.17.
//  Copyright © 2017 Andersen. All rights reserved.
//

import UIKit

protocol DataPickerProtocol: class {
}

final class DataPicker: UIDatePicker {
    
    //public var onSelect = (String) -> ()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setupUI()
        setupData()
    }
    
    // MARK: Private Method
    
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    private func setupData() {
    }
}

extension DataPicker: DataPickerProtocol {
    // data
    // validation
    // string
    
    func some() {
    }
}
