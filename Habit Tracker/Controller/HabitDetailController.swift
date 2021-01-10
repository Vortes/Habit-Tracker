//
//  HabitDetailController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 12/14/20.
//

import UIKit
import RealmSwift
import SAConfettiView

class HabitDetailController: UIViewController {
	
	@IBOutlet weak var habitName: UILabel!
	@IBOutlet weak var habitCount: UILabel!
	@IBOutlet weak var userHabitCount: UILabel!
	@IBOutlet weak var addLabel: UIButton!
	@IBOutlet weak var minusLabel: UIButton!
	@IBOutlet weak var slashLabel: UILabel!
	

	var habitData = Habit()
	let habitDetails = HabitDetail()
	let realm = try! Realm()
	var selectedHabit: Habit?
	var cell: HabitCell?
	let shapeLayer = CAShapeLayer()
	let habitcell = HabitCell()
	
	let customRed = UIColor().customRed()
	let customBlue = UIColor().customBlue()
	let complimentaryBlue = UIColor().complimentaryBlue()
	
	var confettiView: SAConfettiView!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		confettiView = SAConfettiView(frame: self.view.bounds)
		confettiView.isUserInteractionEnabled = false
		
		view.center = CGPoint(x: view.frame.size.width / 2,
							  y: view.frame.size.height / 2.5)
		
		view.backgroundColor = customBlue
		
		userHabitCount.textColor = complimentaryBlue
		habitName.textColor = complimentaryBlue
		habitCount.textColor = complimentaryBlue
		slashLabel.textColor = complimentaryBlue
		addLabel.tintColor = complimentaryBlue
		minusLabel.tintColor = complimentaryBlue
		
		
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
		shapeLayer.strokeColor = UIColor().complimentaryBlue().cgColor
		shapeLayer.lineWidth = 10
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineCap = .round
		shapeLayer.strokeEnd = 0
		shapeLayer.position = view.center
		shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
		
		view.layer.addSublayer(shapeLayer)
		let percentage = CGFloat(Float(Float(Float(self.selectedHabit!.userCount)/Float(self.selectedHabit!.totalCount)!)))
		shapeLayer.strokeEnd = percentage
		
    }
	
	@objc func handleTap() {}
		
	@IBAction func addButton(_ sender: Any) {
		do {
			try realm.write {
				if selectedHabit!.userCount == (Int(selectedHabit!.totalCount )! - 1) {
					selectedHabit!.userCount += 1
					habitcell.habit = selectedHabit
					habitcell.habitXibName?.text = String(selectedHabit?.userCount ?? 0)
					view.addSubview(confettiView)
					confettiView.startConfetti()
					DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
						self.confettiView.stopConfetti()
					}
					NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
				} else {
					selectedHabit!.userCount += 1
					NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
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
					NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
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
	
	@IBAction func completeButton(_ sender: Any) {
		do {
			try realm.write {
				if selectedHabit!.userCount > (Int(selectedHabit!.totalCount )! - 1) {
				} else {
					let complete = ((Int(selectedHabit!.totalCount) ?? 0) - selectedHabit!.userCount)
					selectedHabit!.userCount += complete
					view.addSubview(confettiView)
					confettiView.startConfetti()
					DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
						self.confettiView.stopConfetti()
					}
					NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
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
	
	
}

