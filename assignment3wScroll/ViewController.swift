//
//  ViewController.swift
//  assignment3wScroll
//
//  Created by Peter Driscoll on 2/17/20.
//  Copyright © 2020 Peter Driscoll. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // Mark Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var austinImage: UIImageView!
    @IBOutlet weak var mainTextView: UITextView!
    
    
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
    
    // Mark: UITextViewDelegate
    var userInfo = [String] ()
    
    @IBAction func setMainTextViewText(_ sender: UIButton) {
        if nameTextField.text != "" && cityTextField.text != "" {
            let userInputName = nameTextField.text!
            let userInputCity = cityTextField.text!
            userInfo.append("Name: " + userInputName + ", City: " + userInputCity + "\n")
            mainTextView.text = ""
            for info in userInfo {
                mainTextView.text += info
            }
        }
        nameTextField.text = ""
        cityTextField.text = ""
    }
    
}

