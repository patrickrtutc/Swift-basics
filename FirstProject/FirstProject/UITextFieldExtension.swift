//
//  UITextFieldExtension.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/18/25.
//

import UIKit
import Foundation

extension UITextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
        }
}
