//
//  DetailsViewController.swift
//  FirstUIProj
//
//  Created by Bhushan Abhyankar on 14/02/2025.
//

import UIKit

class DetailsViewController: UIViewController {

    var receivedEmailID: String?
    var receivedPassword: String?
    
    @IBOutlet weak var labelReceivedData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("receivedEmailID = \(receivedEmailID  ?? "-") receivedPassword = \(receivedPassword ?? "-")")
        labelReceivedData.text = "receivedEmailID = \(receivedEmailID  ?? "-") receivedPassword = \(receivedPassword ?? "-")"
    }
    

    @IBAction func navigateToListScreen(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listViewController = storyboard.instantiateViewController(identifier: "ListViewController") as ListViewController
        
        self.navigationController?.pushViewController(listViewController, animated: false)
    }
    
}
