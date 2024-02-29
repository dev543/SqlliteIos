//
//  TextFieldExtension.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 12/01/24.
//

import Foundation
import UIKit

extension UITextField {
    
    //placeholder Function
    
        func placeHolder(placeholder : String,font : UIFont){
            attributedPlaceholder  = NSAttributedString(
                string: placeholder,attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
        }

    //validation regex
    
        func isValidFirstName(testStr:String) -> Bool {
            print("validate FirstName: \(testStr)")
            let FirstName = "[A-Za-z]+"
            let FirstNameTest = NSPredicate(format:"SELF MATCHES %@",FirstName)
            let result = FirstNameTest.evaluate(with: testStr)
            return result
        }
        
        func isValidContectNo(testStr:String) -> Bool {
            print("validate ContactNumber: \(testStr)")
            let Contect = "[0-9]+"
            let ContectTest = NSPredicate(format:"SELF MATCHES %@",Contect)
            let result = ContectTest.evaluate(with: testStr)
            return result
        }
        
        func isValidEmail(testStr:String) -> Bool {
            print("validate emilId: \(testStr)")
            let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@",emailRegEx)
            let result = emailTest.evaluate(with: testStr)
            return result
        }
    
    func setLeftView() {
        
      let iconView = UIImageView(frame: CGRect(x: 12, y: 10, width: 25, height: 25))
        iconView.contentMode = .scaleAspectFill
      let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 45))
      iconContainerView.addSubview(iconView)
      leftView = iconContainerView
      leftViewMode = .always
    
    }
        
}
