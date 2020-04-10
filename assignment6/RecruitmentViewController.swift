//
//  RecruitmentViewController.swift
//  assignment6
//
//  Created by Patricia Cabanilla on 4/5/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit

class RecruitmentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var adventurerName: UITextField!
    @IBOutlet weak var adventurerProfession: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var name: String = ""
    var profession: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adventurerName.delegate = self
        adventurerProfession.delegate = self
        
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        if (adventurerName.text?.count != 0 && adventurerProfession.text?.count != 0) {
            saveButton.isEnabled = true
        }
        else {
            saveButton.isEnabled = false }
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save" {
            name = adventurerName.text!
            profession = adventurerProfession.text!
        }
    }
}
