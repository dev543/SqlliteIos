//
//  ViewClass.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 12/01/24.
//

import Foundation
import UIKit

class viewTheme : UIView {
    
    override func awakeFromNib() {
    
        self.layer.cornerRadius    = 25
        self.layer.borderWidth     = 1
        self.layer.borderColor     = UIColor.gray.cgColor
    
    }
    
}
