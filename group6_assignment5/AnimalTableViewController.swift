//
//  AnimalTableViewController.swift
//  group6_assignment5
//
//  Created by Patricia Cabanilla on 3/1/20.
//  Copyright © 2020 Patricia Cabanilla. All rights reserved.
//

import UIKit

var globalVar = 0


class AnimalTableViewCell : UITableViewCell {
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
}

class DescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var scientificNameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
}

class AnimalTableViewController: UITableViewController {
    
    let animals:[Animal] = [Animal(name: "Greenland Shark", scientificName: "Somniosus microcephalus", animalClass: "Chondrichthyes", size: "1000 kg", image: "greenlandShark"), Animal(name: "Giraffe", scientificName: "Giraffa camelopardalis", animalClass: "Mammilia", size: "1192 kg", image: "giraffe"), Animal(name: "Tuatara", scientificName: "Sphenodon punctatus", animalClass: "Reptilia", size: "1 kg", image:"tuatara"), Animal(name: "Polar Bear", scientificName: "Ursus maritimus", animalClass: "Mammalia", size: "450 kg", image:"polarBear")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalTableViewCell
            
            let animal = animals[indexPath.row / 2]
            
            cell.animalNameLabel?.text = animal.name
            cell.animalImageView?.image = UIImage(named: animal.image)
            
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionTableViewCell
            
            let animal = animals[(indexPath.row - 1) / 2]
            
            cell.scientificNameLabel?.text = animal.scientificName
            cell.classLabel?.text = animal.animalClass
            cell.weightLabel?.text = animal.size
            
            return cell
        }
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalVar = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

