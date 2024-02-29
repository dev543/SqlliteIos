//
//  TextFieldClass.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 12/01/24.
//

import Foundation
import UIKit

class textFieldTheme : UITextField {
    
    override func awakeFromNib() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.layer.cornerRadius    = 20
            self.layer.borderWidth     = 1
            self.layer.borderColor     = UIColor.gray.cgColor
            self.font = UIFont.systemFont(ofSize: 20.0)
            }
    }

}
