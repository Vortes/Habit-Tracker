//
//  HabitDetailController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/14/20.
//

import UIKit
import RealmSwift

class HabitDetailController: UIViewController {
	
	var selectedHabit: Habit? {
		didSet {
			loadHabits()
		}
	}
	
	let realm = try! Realm()
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	func loadHabits() {
		
	}
	
	@IBAction func cancelButton(_ sender: Any) {
		self.navigationController?.popToRootViewController(animated: true)
	}
	
	

}
