//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit
import SwipeCellKit

class tableViewCell: UITableViewCell {
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var habitCount: UILabel!
    
    
    var habit: Habit? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
		print("being run")
        habitName?.text = habit?.title
        habitCount?.text = habit?.detail
//        progressLabel?.observedProgress = habit?.progress
    }
    
}

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var deno_label: UILabel!
	@IBOutlet weak var tableView: UITableView!
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
	@IBOutlet weak var deno_img: UIImageView!
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
//		let indexSet = IndexSet(integer: userHabitData.count)
//		userHabitData.append(HabitDict(habitName: "", habitCount: ""))
//		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//			self.userHabitData.removeAll()
//			self.tableView.deleteSections(indexSet, with: .fade)
//		}
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
		print("userHabitData: \(userHabitData.count)")
		return userHabitData.count
    }
    
    // Adjusts cell spacing between habits
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Adjust row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    // for every section return 1 row
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
		if habitIsEmpty() {
			deno_img.alpha = 0.0
			deno_label.alpha = 0.0
		}
		print("making habit")
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) as! tableViewCell
        let dictKey = userHabitData[indexPath.section].getName()
        let dictValue = userHabitData[indexPath.section].getCount()
//        cell.delegate = self
        cell.backgroundColor = customBlue
        cell.layer.cornerRadius = 10
        cell.habit = Habit(title: dictKey, detail: dictValue)
		print("userHabitData in making habit: \(userHabitData.count)")
        return cell
    }
	
//	func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//		var options = SwipeOptions()
//		options.expansionStyle = .destructive
//		options.transitionStyle = .border
//		return options
//	}
	
	func tableView(_ tableView: UITableView,
				   commit editingStyle: UITableViewCell.EditingStyle,
				   forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let indexSet = IndexSet(integer: userHabitData.count - 1)
			userHabitData.remove(at: indexPath.section)
			tableView.deleteSections(indexSet, with: .fade)
			// Perform any follow up actions here
		}
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
    
//    func allowMultipleLines(tableViewCell: UITableViewCell) {
//        tableViewCell.textLabel?.lineBreakMode = .byWordWrapping
//    }
	
	func habitIsEmpty() -> Bool {
		if userHabitData.isEmpty {
			return false
		} else {
			return true
		}
	}
    
}

extension HomeController: CreateGoalDelegate {
    func didTapSave(name: String, count: String) {
		print("inserting sections")
        userHabitName = name
        userHabitCount = count
        UserHabitDict[name] = count
        userHabitData.append(HabitDict(habitName: name, habitCount: count))
		let indexSet = IndexSet(integer: userHabitData.count - 1)
		tableView.insertSections(indexSet, with: .right)
		print("userHabitData in inserting sections: \(userHabitData.count)")
//		self.userHabitData.remove(at: 0)
//		self.tableView.deleteSections(indexSet, with: .fade)
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

//extension HomeController: SwipeTableViewCellDelegate {
//	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
////		let indexSet = IndexSet(integer: userHabitData.count - 1)
////		print("in delete")
//		let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
////			print("currently deleting")
////			userHabitData.remove(at: indexPath.section)
////			tableView.deleteSections(indexSet, with: .fade)
//        }
////
////        // customize the action appearance
////        deleteAction.image = UIImage(named: "delete")
////
//        return [deleteAction]
//    }
//}







