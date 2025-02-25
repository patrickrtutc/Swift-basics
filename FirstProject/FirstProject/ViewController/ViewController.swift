//
//  ViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/13/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let viewModel = ViewModel()

    @IBOutlet weak var LabelSignIn: UILabel!
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var ErrorEmail: UILabel!
    @IBOutlet weak var ErrorPassword: UILabel!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var ButtonSignIn: UIButton!
    @IBOutlet weak var ButtonForgotPassword: UIButton!
    @IBOutlet weak var ButtonSignInFacebook: UIButton!
    @IBOutlet weak var ButtonSignInGoogle: UIButton!
    @IBOutlet weak var ButtonSignUp: UIButton!
    @IBOutlet weak var LabelSignUp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        setupUI()
        
        TextFieldEmail.delegate = self
        TextFieldPassword.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == TextFieldEmail {
                if let text = textField.text as NSString? {
                    let updatedText = text.replacingCharacters(in: range, with: string)
                    if viewModel.invalidEmail(updatedText) == nil {
                        ErrorEmail.isHidden = true
                    }
                }
            } else if textField == TextFieldPassword {
                if let text = textField.text as NSString? {
                    let updatedText = text.replacingCharacters(in: range, with: string)
                    if viewModel.invalidPassword(updatedText) == nil {
                        ErrorPassword.isHidden = true
                    }
                }
            }
        
        DispatchQueue.main.async {
               self.checkFormValidity()
           }
            return true
    }
    
    func resetForm()
    {
        ButtonSignIn.isEnabled = false
        
        ErrorEmail.isHidden = false
        ErrorPassword.isHidden = false
        
        ErrorEmail.text = "Required"
        ErrorPassword.text = "Required"
        
        TextFieldEmail.text = ""
        TextFieldPassword.text = ""
    }
    
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = TextFieldEmail.text {
            if let errorMsg = viewModel.invalidEmail(email) {
                ErrorEmail.text = errorMsg
                ErrorEmail.isHidden = false
            } else
            {
                ErrorEmail.isHidden = true
            }
        }
        checkFormValidity()
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = TextFieldPassword.text {
            if let errorMsg = viewModel.invalidPassword(password) {
                ErrorPassword.text = errorMsg
                ErrorPassword.isHidden = false
            } else
            {
                ErrorPassword.isHidden = true
            }
        }
        checkFormValidity()
    }
    
    
    func checkFormValidity()
    {
        guard ErrorEmail.isHidden, ErrorPassword.isHidden else { ButtonSignIn.isEnabled = false;
            return
        }
        ButtonSignIn.isEnabled = true
    }
    
    @IBAction func submitAction(_ sender: Any) {
        print("Login Successful")
    }

    func setupUI() {
        LabelSignIn.textColor = .label
        LabelSignIn.font = .systemFont(ofSize: 24, weight: .bold)
        TextFieldEmail.textColor = .label
        TextFieldEmail.placeholder = "E-mail"
        TextFieldEmail.addBottomBorder()
        TextFieldPassword.textColor = .label
        TextFieldPassword.placeholder = "Password"
        TextFieldPassword.addBottomBorder()
        ButtonSignIn.setTitleColor(.label, for: .normal)
        ButtonSignIn.layer.cornerRadius = 16
        ButtonSignIn.layer.masksToBounds = true
        ButtonForgotPassword.setTitleColor(.label, for: .normal)
        ButtonSignInFacebook.setTitleColor(.label, for: .normal)
        ButtonSignInFacebook.layer.cornerRadius = 16
        ButtonSignInFacebook.layer.masksToBounds = true
        ButtonSignInGoogle.setTitleColor(.label, for: .normal)
        ButtonSignInGoogle.layer.cornerRadius = 16
        ButtonSignInGoogle.layer.masksToBounds = true
    }
}

