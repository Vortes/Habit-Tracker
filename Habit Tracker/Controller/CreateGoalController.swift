//
//  NewGoalViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit
import CLTypingLabel

protocol CreateGoalDelegate {
    func didTapSave(name: String, count: String)
}

class CreateGoalController: UIViewController {
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .heavy)
    @IBOutlet weak var titleName: CLTypingLabel!
    @IBOutlet weak var goalName: UITextField!
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var habitCount: UITextField!
	
    
    var habitDelegate: CreateGoalDelegate! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalName.delegate = self
        titleName.text = "C R E A T E  ✍️"
		button.layer.cornerRadius = 30
    }
    
    @IBAction func Save(_ sender: UIButton) {
        habitDelegate.didTapSave(name: goalName.text!, count: habitCount.text!)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
