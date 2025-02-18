//
//  ViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/13/25.
//

import UIKit

class ViewController: BaseViewController {

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
            if let errorMsg = invalidEmail(email) {
                ErrorEmail.text = errorMsg
                ErrorEmail.isHidden = false
            } else
            {
                ErrorEmail.isHidden = true
            }
        }
        checkFormValidity()
    }
    
    func invalidEmail(_ email: String) -> String? {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if predicate.evaluate(with: email) == false {
            return "Invalid Email Address"
        }
        return nil
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = TextFieldPassword.text {
            if let errorMsg = invalidPassword(password) {
                ErrorPassword.text = errorMsg
                ErrorPassword.isHidden = false
            } else
            {
                ErrorPassword.isHidden = true
            }
        }
        checkFormValidity()
    }
    
    func invalidPassword(_ password: String) -> String? {
        guard password.count >= 8 else {
            return "Password must be at least 8 characters long"
        }
        guard password.rangeOfCharacter(from: .whitespacesAndNewlines) == nil else {
            return "Password must not contain whitespace"
        }
        guard password.rangeOfCharacter(from: .uppercaseLetters) != nil else {
            return "Password must contain uppercase letter"
        }
        guard password.isEmpty == false else {
            return "Password cannot be empty"
        }
        guard password.contains(where: { $0.isNumber }) else {
            return "Password must contain a number"
        }
        guard password.rangeOfCharacter(from: .lowercaseLetters) != nil else {
            return "Password must contain lowercase letter"
        }
        guard password.rangeOfCharacter(from: .punctuationCharacters) != nil else {
            return "Password must contain punctuation"
        }
        return nil
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
        addBottomBorder(to: TextFieldEmail)
        TextFieldPassword.textColor = .label
        TextFieldPassword.placeholder = "Password"
        addBottomBorder(to: TextFieldPassword)
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

