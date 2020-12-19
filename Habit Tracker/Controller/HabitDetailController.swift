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

	var habitData = Habit()
	let habitDetails = HabitDetail()
	let realm = try! Realm()
	var selectedHabit: Habit?
	let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.center = CGPoint(x: view.frame.size.width / 2,
							  y: view.frame.size.height / 2.5)
		
		userHabitCount.text = String(selectedHabit!.userCount)
		habitName.text = selectedHabit!.title
		habitCount.text = selectedHabit!.totalCount
		
		let circularPath = UIBezierPath(arcCenter: .zero, radius: 150, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
		
		// Track Layer
		let trackLayer = CAShapeLayer()
		trackLayer.path = circularPath.cgPath
		trackLayer.strokeColor = UIColor.lightGray.cgColor
		trackLayer.lineWidth = 10
		trackLayer.fillColor = UIColor.clear.cgColor
		trackLayer.lineCap = .round
		trackLayer.position = view.center
		view.layer.addSublayer(trackLayer)
	
		// Progress Layer
		shapeLayer.path = circularPath.cgPath
		shapeLayer.strokeColor = UIColor.green.cgColor
		shapeLayer.lineWidth = 10
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineCap = .round
		shapeLayer.strokeEnd = 0
		shapeLayer.position = view.center
		shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
		
		view.layer.addSublayer(shapeLayer)
		let percentage = CGFloat(Float(Float(Float(self.selectedHabit!.userCount)/Float(self.selectedHabit!.totalCount)!)))
		shapeLayer.strokeEnd = percentage
		
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
	
	@objc func handleTap() {}
	
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
		
		let percentage = CGFloat(Float(Float(Float(self.selectedHabit!.userCount)/Float(self.selectedHabit!.totalCount)!)))
		
		DispatchQueue.main.async {
			self.shapeLayer.strokeEnd = percentage
		}
		
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
		
		let percentage = CGFloat(Float(Float(Float(self.selectedHabit!.userCount)/Float(self.selectedHabit!.totalCount)!)))
		
		DispatchQueue.main.async {
			self.shapeLayer.strokeEnd = percentage
		}
		
		userHabitCount.text = String(selectedHabit!.userCount)
		
	}
	
	@IBAction func cancelButton(_ sender: Any) {
//		self.navigationController?.popToRootViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}
}
