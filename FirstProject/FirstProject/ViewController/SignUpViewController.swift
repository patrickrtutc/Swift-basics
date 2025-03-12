//
//  SignUpViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/17/25.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var LabelSignUp: UILabel!
    
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var TextFieldRepeatPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        }
    
    func setupUI() {
        LabelSignUp.text = "Sign Up"
        LabelSignUp.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        TextFieldEmail.placeholder = "E-mail"
        TextFieldEmail.addBottomBorder()
        TextFieldPassword.placeholder = "Password"
        TextFieldPassword.addBottomBorder()
        TextFieldRepeatPassword.placeholder = "Repeat Password"
        TextFieldRepeatPassword.addBottomBorder()
    }
}
    
    
