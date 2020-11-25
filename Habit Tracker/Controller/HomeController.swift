//
//  ViewController.swift
//  Habit Tracker
//
//  Created by Alan Weng on 11/24/20.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func createNewGoal(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCreateView", sender: self)
    }
    
}

