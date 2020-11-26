//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userHabitsList: [String] = []
    var userHabitName: String?
    var userHabitCount: String?
    let cellReuseID = "habitName"
    let cellSpacingHeight: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    @IBAction func createNewGoal(_ sender: Any) {
        let goalVC = storyboard?.instantiateViewController(withIdentifier: cellReuseID) as! CreateGoalController
        goalVC.habitDelegate = self
        present(goalVC, animated: true, completion: nil)
    }
    
    // Think of how ios settings have different sections w diff spacings
    func numberOfSections(in tableView: UITableView) -> Int {
        return userHabitsList.count
    }
    
    // Adjusts cell spacing between habits
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Adjust row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // Allows the table to keep expanding based on how many habits are in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseID)!
        
        // note that indexPath.section is used rather than indexPath.row
        cell.textLabel?.text = userHabitsList[indexPath.section]
        // add border and color
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.blue
        cell.textLabel?.textColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1.5
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.section).")
    }
    
}

extension HomeController: CreateGoalDelegate {
    func didTapSave(name: String, count: String) {
        userHabitName = name
        userHabitCount = count
        print(userHabitCount!)
        userHabitsList.append(name)
        tableView.reloadData()
    }
}
