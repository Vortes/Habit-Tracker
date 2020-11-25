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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    @IBAction func createNewGoal(_ sender: Any) {
        let goalVC = storyboard?.instantiateViewController(withIdentifier: "habitName") as! CreateGoalController
        goalVC.habitDelegate = self
        present(goalVC, animated: true, completion: nil)
    }
    
    // Think of how ios settings have different sections w diff spacings
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Allows the table to keep expanding based on how many habits are in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userHabitsList.count
    }
    
    // Actually puts the words in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitName")!
        // indexPath.row allows the cell to use the most recent added habit
        cell.textLabel?.text = userHabitsList[indexPath.row]
        return cell
    }
}

extension HomeController: CreateGoalDelegate {
    func didTapSave(name: String) {
        userHabitName = name
        userHabitsList.append(name)
        tableView.reloadData()
    }
}
