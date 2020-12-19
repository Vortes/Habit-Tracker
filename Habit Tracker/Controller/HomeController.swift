//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit
import SwipeCellKit
import RealmSwift
import ChameleonFramework

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var deno_label: UILabel!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var deno_img: UIImageView!
	@IBOutlet weak var addHabitLabel: UIButton!
	
	let realm = try! Realm()
	
	var habitData: Results<Habit>?
	
	let impactHard = UIImpactFeedbackGenerator(style: .heavy)
	let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    let cellReuseID = "habitName"
    let cellSpacingHeight: CGFloat = 10
    let customRed = UIColor().customRed()
	let customBlue = UIColor().customBlue()
	let complimentaryBlue = UIColor().complimentaryBlue()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
		tableView.backgroundColor = customBlue
		tableView.layer.cornerRadius = 30
		tableView.clipsToBounds = false
		tableView.layer.masksToBounds = false
		tableView.layer.shadowColor = UIColor.darkGray.cgColor
		tableView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
		tableView.layer.shadowOpacity = 0.35
		tableView.layer.shadowRadius = 3
		print(Realm.Configuration.defaultConfiguration.fileURL!)
		
		loadItems()
    }
	
	override func viewDidLayoutSubviews() {
		addHabitLabel.layer.cornerRadius = 0.5 * addHabitLabel.bounds.size.width
		addHabitLabel.clipsToBounds = true
		addHabitLabel.layer.shadowColor = UIColor.darkGray.cgColor
		addHabitLabel.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
		addHabitLabel.layer.shadowOpacity = 1.0
		addHabitLabel.layer.shadowRadius = 10
	}

    @IBAction func createNewGoal(_ sender: Any) {
        let goalVC = storyboard?.instantiateViewController(withIdentifier: cellReuseID) as! CreateGoalController
        impactHard.prepare()
        impactHard.impactOccurred()
        goalVC.habitDelegate = self
        present(goalVC, animated: true, completion: nil)
    }
    
    // Think of how ios settings have different sections w diff spacings
    func numberOfSections(in tableView: UITableView) -> Int {
		
		if habitData?.count ?? 0 == 0 {
			deno_img.alpha = 0.4
			deno_label.alpha = 0.4
		} else {
			deno_img.alpha = 0.0
			deno_label.alpha = 0.0
		}
		
		return habitData?.count ?? 0
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID) as! tableViewCell
		cell.delegate = self
        cell.backgroundColor = complimentaryBlue
        cell.layer.cornerRadius = 10
		cell.habit = habitData?[indexPath.section]
		
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "habitDetails", sender: self)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! HabitDetailController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedHabit = habitData?[indexPath.section]
		}
	}

    
    func allowMultipleLines(tableViewCell: UITableViewCell) {
        tableViewCell.textLabel?.lineBreakMode = .byWordWrapping
    }
	
	func save(habit: Habit) {
		do {
			try realm.write {
				realm.add(habit)
			}
		} catch {
			print("saving error \(error)")
		}
	}
	
	func loadItems() {
		habitData = realm.objects(Habit.self)
	}

}

extension HomeController: CreateGoalDelegate {
    func didTapSave(name: String, count: String) {
		print("inserting sections")
		
		let newHabit = Habit()
		newHabit.title = name
		newHabit.totalCount = count

		save(habit: newHabit)
		tableView.reloadData()
    }
}

extension UIColor {
    func customRed() -> UIColor {
        return UIColor(red: 0.607, green: 0.160, blue: 0.282, alpha: 1.00)
    }
    func customBlue() -> UIColor {
        return UIColor(red: 0.636, green: 0.855, blue: 0.875, alpha: 1.00)
    }
	
	func complimentaryBlue() -> UIColor {
		return ComplementaryFlatColorOf(customBlue())
	}
	
}

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
		habitCount?.text = habit?.totalCount
	}
	
}


extension HomeController: SwipeTableViewCellDelegate {
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }

		let deleteAction = SwipeAction(style: .destructive, title: "") { action, indexPath in
			if let habitForDeletion = self.habitData?[indexPath.section] {
				do {
					try self.realm.write {
						self.realm.delete(habitForDeletion)
						self.impactMedium.prepare()
						self.impactMedium.impactOccurred()
					}
				} catch {
					print("error deleting \(error)")
				}
				tableView.reloadData()
			}
		}

		// customize the action appearance
		deleteAction.image = UIImage(named: "delete")

		return [deleteAction]
	}
//
//	func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//		var options = SwipeOptions()
//		options.expansionStyle = .destructive
//		options.transitionStyle = .border
//		return options
//	}
	
}
