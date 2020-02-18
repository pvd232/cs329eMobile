//
//  ViewController.swift
//  pvd232_assignment3
//
//  Created by Driscoll, Peter V on 2/16/20.
//  Copyright © 2020 cs329e. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Mark Properties
    @IBOutlet weak var nameHometownLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var austinImage: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        cityTextField.delegate = self
        nameTextField.returnKeyType = UIReturnKeyType.done
        cityTextField.returnKeyType = UIReturnKeyType.done
        
        
    }
    //Mark: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    
}

