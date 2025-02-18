//
//  ViewController.swift
//  FirstUIProj
//
//  Created by Bhushan Abhyankar on 13/02/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelWelcome: UILabel!
    
    @IBOutlet weak var labelScreenTitle: UILabel!
    
    @IBOutlet weak var buttonLogin: UIButton!
    
    @IBOutlet weak var textFieldEmailID: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMyUI()
    }

    func setUpMyUI(){
        labelWelcome.text = "Hello UI development"
        labelWelcome.textColor = .cyan
        
        labelScreenTitle.text = "Welcome to First UI Project"
        
        buttonLogin.setTitle("SignUp", for: .normal)
        buttonLogin.layer.cornerRadius = 30

    }

    @IBAction func buttonForgotPasswordClickec(_ sender: Any) {
        print("button ForgotPassword Clicked")

    }
    @IBAction func loginButtonClicked(_ sender: Any) {
      print("Login Button Clicked")
        let emailID = textFieldEmailID.text
        let password = textFieldPassword.text
        print("Email is \(emailID ?? "") and Password is \(password ?? "")")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController") as DetailsViewController
        detailsViewController.receivedEmailID = emailID
        detailsViewController.receivedPassword = password
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

