//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit
import SwipeCellKit

class tableViewCell: SwipeTableViewCell {
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var habitCount: UILabel!
    
    
    var habit: Habit? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        habitName?.text = habit?.title
        habitCount?.text = habit?.detail
//        progressLabel?.observedProgress = habit?.progress
    }
    
}

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
    var UserHabitDict: [String:String] = [:]
    var userHabitData = [HabitDict]()
    var userHabitName: String?
    var userHabitCount: String?
    let cellReuseID = "habitName"
    let cellSpacingHeight: CGFloat = 15
    let customRed = UIColor().customRed()
    let customBlue = UIColor().customBlue()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    @IBAction func createNewGoal(_ sender: Any) {
        let goalVC = storyboard?.instantiateViewController(withIdentifier: cellReuseID) as! CreateGoalController
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        goalVC.habitDelegate = self
        present(goalVC, animated: true, completion: nil)
    }
    
    // Think of how ios settings have different sections w diff spacings
    func numberOfSections(in tableView: UITableView) -> Int {
        return UserHabitDict.count
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) as! tableViewCell
        let dictKey = userHabitData[indexPath.section].getName()
        let dictValue = userHabitData[indexPath.section].getCount()
        cell.delegate = self
        cell.backgroundColor = customBlue
        cell.layer.cornerRadius = 10
        cell.habit = Habit(title: dictKey, detail: dictValue)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
//        print("You tapped cell number \(indexPath.section).")
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) as! tableViewCell
//		cell.habit?.updateDetail()
//		tableView.reloadData()
//        let dictKey = userHabitData[indexPath.section].getName()
//        var dictValue = userHabitData[indexPath.section].getCount()
//        print("over here")
//        dictValue = String(Int(dictValue)! - 1)
//        print(dictValue)
//        cell.habit = Habit(title: dictKey, detail: dictValue)
//        tableView.reloadData()
		
    }
    
    func allowMultipleLines(tableViewCell: UITableViewCell) {
        tableViewCell.textLabel?.lineBreakMode = .byWordWrapping
    }
    
}

extension HomeController: CreateGoalDelegate {
    func didTapSave(name: String, count: String) {
        userHabitName = name
        userHabitCount = count
        UserHabitDict[name] = count
        userHabitData.append(HabitDict(habitName: name, habitCount: count))
//        print(userHabitData[0].getCount())
        tableView.reloadData()
    }
}

extension UIColor {
    func customRed() -> UIColor {
        return UIColor(red: 0.607, green: 0.160, blue: 0.282, alpha: 1.00)
    }
    func customBlue() -> UIColor {
        return UIColor(red: 0.509, green: 0.701, blue: 0.964, alpha: 1.00)
    }
}

struct HabitDict {
    let habitName: String
    let habitCount: String
    
    func getName() -> String {
        return habitName
    }
    
    func getCount() -> String {
        return habitCount
    }
}

extension HomeController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Deleted")
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
}







