//
//  NewGoalViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit

class CreateGoalController: UIViewController {

    @IBOutlet weak var goalName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalName.delegate = self
    }
    
    @IBAction func Save(_ sender: UIButton) {
        print(goalName.text!)
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
