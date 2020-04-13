//
//  RecruitmentViewController.swift
//  assignment6
//
//  Created by Patricia Cabanilla on 4/5/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit

class RecruitmentViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let imageNames:[String] = ["Sceptile", "Blaziken", "Swampert", "Pikachu"]
    @IBOutlet weak var adventurerName: UITextField!
    @IBOutlet weak var adventurerProfession: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var name: String = ""
    var profession: String = ""
    var portrait: String = ""
    
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
        if (adventurerName.text?.count != 0 && adventurerProfession.text?.count != 0 && Idx != nil) {
            saveButton.isEnabled = true
        }
        else {
            saveButton.isEnabled = false }
    }
    
    // MARK: CollectionView functions
    
    var Idx:IndexPath?
    var imageName:String = ""
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! SelectAppearanceCollectionViewCell
        cell.Image.image = UIImage(named: imageNames[indexPath.row])
        cell.imageName = imageNames[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Idx != nil {
            collectionView.deselectItem(at: Idx!, animated: false)
        }
        Idx = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! SelectAppearanceCollectionViewCell
        imageName = cell.imageName
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        updateSaveButtonState()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Save" {
            name = adventurerName.text!
            profession = adventurerProfession.text!
            portrait = imageName
        }
    }
}
