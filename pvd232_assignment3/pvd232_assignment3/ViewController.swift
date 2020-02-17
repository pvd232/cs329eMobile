//
//  ViewController.swift
//  pvd232_assignment3
//
//  Created by Driscoll, Peter V on 2/16/20.
//  Copyright © 2020 cs329e. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var hometownLabel: UILabel!
    func align () {
        hometownLabel.textAlignment = .center
    }

}

