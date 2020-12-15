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
//	var habitDetailData: Results<HabitDetail>?
	var habitData = Habit()
	let habitDetails = HabitDetail()
	let habit = Habit()
	let realm = try! Realm()
	var selectedHabit: Habit? 
	
    override func viewDidLoad() {
        super.viewDidLoad()
		print(habitData.progress)
		habitName.text = String(selectedHabit?.progress ?? 0)
//		loadItems()
    }
	
//	func loadDetail() {}
//	
//	func loadItems() {
//		habitData = realm.objects(Habit.self)
//	}
	
	@IBAction func cancelButton(_ sender: Any) {
		self.navigationController?.popToRootViewController(animated: true)
	}
	
	

}
