//
//  NewGoalViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit

protocol CreateGoalDelegate {
    func didTapSave(name: String, count: String)
}

class CreateGoalController: UIViewController {

    @IBOutlet weak var goalName: UITextField!
    @IBOutlet weak var habitCount: UITextField!
    
    
    var habitDelegate: CreateGoalDelegate! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalName.delegate = self
    }
    
    @IBAction func Save(_ sender: UIButton) {
        habitDelegate.didTapSave(name: goalName.text!, count: habitCount.text!)
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
