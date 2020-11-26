//
//  NewGoalViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit

protocol CreateGoalDelegate { func didTapSave(name:String) }

class CreateGoalController: UIViewController {

    @IBOutlet weak var goalName: UITextField!
    
    var habitDelegate: CreateGoalDelegate! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalName.delegate = self
    }
    
    @IBAction func Save(_ sender: UIButton) {
        habitDelegate.didTapSave(name: goalName.text!)
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
