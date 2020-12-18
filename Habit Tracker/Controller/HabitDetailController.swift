//
//  HabitDetailController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/14/20.
//

import UIKit
import RealmSwift

class HabitDetailController: UIViewController {
	
	@IBOutlet weak var habitName: UILabel!
	@IBOutlet weak var habitCount: UILabel!
	@IBOutlet weak var userHabitCount: UILabel!
	@IBOutlet weak var habitProgress: UIProgressView!

	var habitData = Habit()
	let habitDetails = HabitDetail()
	let realm = try! Realm()
	var selectedHabit: Habit?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		userHabitCount.text = String(selectedHabit!.userCount)
		habitName.text = selectedHabit!.title
		habitCount.text = selectedHabit!.totalCount
		habitProgress.progress = Float(Float(Float(selectedHabit!.userCount)/Float(selectedHabit!.totalCount)!))
    }
	
	@IBAction func addButton(_ sender: Any) {
		do {
			try realm.write {
				if selectedHabit!.userCount == Int(selectedHabit!.totalCount) {
					selectedHabit!.userCount += 1
				} else {
					selectedHabit!.userCount += 1
				}
			}
		} catch {
			print(error)
		}
		
		habitProgress.progress = Float(Float(Float(selectedHabit!.userCount)/Float(selectedHabit!.totalCount)!))
		userHabitCount.text = String(selectedHabit!.userCount)
		}
	
	@IBAction func minusButton(_ sender: Any) {
		do {
			try realm.write {
				if selectedHabit!.userCount <= 0 {}
				else {
					selectedHabit!.userCount -= 1
				}
			}
		} catch {
			print(error)
		}
		habitProgress.progress = Float(Float(Float(selectedHabit!.userCount)/Float(selectedHabit!.totalCount)!))
		userHabitCount.text = String(selectedHabit!.userCount)
		
	}
	
	@IBAction func cancelButton(_ sender: Any) {
//		self.navigationController?.popToRootViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}
}
