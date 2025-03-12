//
//  ForgotPasswordViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/17/25.
//

import UIKit

class ForgotPasswordViewController : UIViewController {
    
    let viewModel = ViewModel()
    @IBOutlet weak var LabelTitle: UILabel!
    @IBOutlet weak var TextFieldEmail: UITextField!
    @IBOutlet weak var ButtonResetPassword: UIButton!
    @IBOutlet weak var LabelInstruction: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        LabelTitle.text = "Reset Password"
        LabelTitle.font = .systemFont(ofSize: 24, weight: .bold)
        TextFieldEmail.placeholder = "E-mail"
        TextFieldEmail.addBottomBorder()
        LabelInstruction.numberOfLines = 0
    }
}
