//
//  TextViewExtension.swift
//  DemoProject
//
//  Created by MacbookAir_32 on 17/01/24.
//

import Foundation
import UIKit
import UIKit

extension UITextView {

    func addPlaceholder(_ placeholder: String, font: UIFont? = nil, textColor: UIColor? = .lightGray, textAlignment: NSTextAlignment = .left) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = font ?? self.font
        placeholderLabel.textColor = textColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 100
        placeholderLabel.isHidden = !self.text.isEmpty

        self.addSubview(placeholderLabel)
        self.resizePlaceholderLabel()

        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged), name: UITextView.textDidChangeNotification, object: nil)
    }

    private func resizePlaceholderLabel() {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            let labelX = self.textContainerInset.left + 5
            let labelY = self.textContainerInset.top
            let labelWidth = self.frame.width - (labelX + self.textContainerInset.right + 5)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }

    @objc private func textChanged() {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }

    func setPlaceholderTextColor(_ color: UIColor) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.textColor = color
        }
    }

    func setPlaceholderText(_ text: String) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.text = text
        }
    }
}
