//
//  ListViewController.swift
//  FirstUIProj
//
//  Created by Bhushan Abhyankar on 14/02/2025.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var myTabelView: UITableView!
    
    let weekDays = ["Sun","Mon","tues","Wed","Thurs","Frid","Sat"]
    
    let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    let weekDaysArray = [MyData(imageName: "sun", title: "Sun"),MyData(imageName: "MOn", title: "Sun"),MyData(imageName: "Tures", title: "Sun")]

    override func viewDidLoad() {
        super.viewDidLoad()

        myTabelView.dataSource = self
        myTabelView.delegate = self
    }
}

extension ListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return weekDays.count
        case 1:
            return months.count
        default:
            return months.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        var data = ""
        switch indexPath.section {
        case 0:
            data = weekDays[indexPath.row]
            listCell.cellImageView.image = UIImage(systemName: "sun.max")
        case 1:
            data = months[indexPath.row]
            listCell.cellImageView.image = UIImage(systemName: "calendar.circle.fill")?.withTintColor(.brown)

        default:
            data = months[indexPath.row]
            listCell.cellImageView.image = UIImage(systemName: "calendar.circle.fill")?.withTintColor(.brown)
        }
        listCell.labelTitle.text = data
        return listCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension ListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data = ""
        switch indexPath.section {
        case 0:
            data = weekDays[indexPath.row]
        case 1:
            data = months[indexPath.row]
        default:
            data = months[indexPath.row]
        }
        print(data)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(identifier: "DetailsViewController") as DetailsViewController
        detailsViewController.receivedEmailID = data
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
struct MyData{
    let imageName:String
    let title:String
}
