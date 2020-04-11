//
//  AdventurerTableViewController.swift
//  assignment6
//
//  Created by Peter Vail Driscoll II on 4/4/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit
import CoreData

let imageNames:[String] = ["Sceptile", "Blaziken", "Swampert", "Pikachu"]

class AdventurerTableViewController: UITableViewController {
    
    @IBOutlet var adventurerTableView: UITableView!
    
    var adventurers = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
     
    /*override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unable to fetch \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            people = results
        }

    }*/

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adventurers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let adventurer = adventurers[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "adventurerCell", for: indexPath) as? AdventurerTableViewCell
        else {
             fatalError("The dequeued cell is not an instance of AdventurerTableViewCell.")
         }
        
        cell.adventurerName?.text = adventurer.value(forKeyPath: "name") as? String
        cell.adventurerProfession?.text = adventurer.value(forKeyPath: "profession") as? String
        let level:Int = adventurer.value(forKey: "level") as! Int
        cell.adventurerLevel?.text = String(level)
        let attack: Float = adventurer.value(forKey: "attackModifier") as! Float
        cell.adventurerAttack?.text = String(format: "%.2f", attack)
        let currentHP: Int = adventurer.value(forKey: "currentHitPoints") as! Int
        cell.adventurerCurrentHP?.text = String(currentHP)
        let totalHP: Int = adventurer.value(forKey: "totalHitPoints") as! Int
        cell.adventurerTotalHP?.text = String(totalHP)
        cell.adventurerPortrait.image = UIImage(named: adventurer.value(forKey: "portrait") as! String)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation
    @IBAction func cancel(segue:UIStoryboardSegue) {

    }

    @IBAction func save(segue:UIStoryboardSegue) {

        let recruitmentVC = segue.source as! RecruitmentViewController
        let newAdventurerName = recruitmentVC.name
        let newAdventurerProfession = recruitmentVC.profession
        let newAdventurerPortrait = recruitmentVC.imageName
        let newAdventurerLevel = 1
        let newAdventurerAttack = Float.random(in: 1.0 ... 5.0)
        let newAdventurerCurrentHP = Int.random(in: 80 ... 150)
        let newAdventurerTotalHP = newAdventurerCurrentHP
        
        print(newAdventurerPortrait)
        
        addAdventurer(name: newAdventurerName, profession: newAdventurerProfession, level: newAdventurerLevel, attackModifier: newAdventurerAttack, currentHitPoints: newAdventurerCurrentHP, totalHitPoints: newAdventurerTotalHP, portrait: newAdventurerPortrait)
        tableView.reloadData()
         
    }
    
    @IBAction func endQuest(segue:UIStoryboardSegue) {

    }
    
    func addAdventurer(name: String, profession: String, level: Int, attackModifier: Float, currentHitPoints: Int, totalHitPoints: Int, portrait: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
        
        let adventurer = NSManagedObject(entity: entity, insertInto: managedContext)
        
        adventurer.setValue(name, forKey: "name")
        adventurer.setValue(profession, forKey: "profession")
        adventurer.setValue(level, forKey: "level")
        adventurer.setValue(attackModifier, forKey: "attackModifier")
        adventurer.setValue(currentHitPoints, forKey: "currentHitPoints")
        adventurer.setValue(totalHitPoints, forKey: "totalHitPoints")
        
        adventurer.setValue(portrait, forKey: "portrait")
        
        do {
            try managedContext.save()
            adventurers.append(adventurer)
        } catch let error as NSError {
            print("Could not add adventurer. \(error), \(error.userInfo)")}
    }
    
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
