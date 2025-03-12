//
//  ViewController.swift
//  TabBarProject
//
//  Created by Patrick Tung on 2/20/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func moveToNextScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        self.present(newScreen, animated: true, completion: nil)
    }


}

