//
//  BaseViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/17/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addBottomBorder(to textField: UITextField) {
            let bottomLine = CALayer()
            bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
            bottomLine.backgroundColor = UIColor.lightGray.cgColor
            textField.borderStyle = .none
            textField.layer.addSublayer(bottomLine)
        }
    
}
