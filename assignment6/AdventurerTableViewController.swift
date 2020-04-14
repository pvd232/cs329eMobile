//
//  AdventurerTableViewController.swift
//  assignment6
//
//  Created by Peter Vail Driscoll II on 4/4/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit
import CoreData
import os


class AdventurerTableViewController: UITableViewController {
    
    @IBOutlet var adventurerTableView: UITableView!
    
    var adventurers = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Adventurer")
        var fetchedResults:[NSManagedObject]? = nil
        // uncomment this block if you want to delete all instances of the adventurers and or enemies for development purposes
        //        var fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Adventurer")
        //        var deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //
        //        do {
        //            try managedContext.execute(deleteRequest)
        //        } catch var error as NSError {
        //            NSLog("Unable to fetch \(error), \(error.userInfo)")
        //        }
        //        fetchRequest = NSFetchRequest(entityName: "Enemy")
        //        deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //
        //        do {
        //            try managedContext.execute(deleteRequest)
        //        } catch let error1 as NSError {
        //            NSLog("Unable to fetch \(error1), \(error1.userInfo)")
        //        }
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unable to fetch \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            adventurers = results
        }
        
        
    }
    
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
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete from core data
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return os_log("error accessing AppDelegate")
                
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let adventurerToRemove = adventurers[indexPath.row]
            managedContext.delete(adventurerToRemove)
            appDelegate.saveContext()
            
            // Delete from tableview
            adventurers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
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
        
        let enemyNames :[String] = ["Charzard", "Snorlax", "Ditto", "Lucario", "Gyrados"]
        let newEnemyName = enemyNames[Int.random(in: 0 ... 4)]
        
        let recruitmentVC = segue.source as! RecruitmentViewController
        let newAdventurerName = recruitmentVC.name
        let newAdventurerProfession = recruitmentVC.profession
        let newAdventurerPortrait = recruitmentVC.imageName
        let newAdventurerLevel = 1
        let newAdventurerAttack = Float.random(in: 1.0 ... 5.0)
        let newAdventurerCurrentHP = Int.random(in: 80 ... 150)
        let newAdventurerDefence = Float.random(in: 1.0 ... 5.0)
        let newAdventurerTotalHP = newAdventurerCurrentHP
        let newAdventurerSpeed = Int.random(in: 1 ... 10)
        let newEnemiesDefeated = 0
        
        let newEnemyAttack = Float.random(in: 1.0 ... 5.0)
        let newEnemyDefense = Float.random(in: 1.0 ... 5.0)
        let newEnemyCurrentHP = Int.random(in: 80 ... 150)
        let newEnemyTotalHP = newEnemyCurrentHP
        let newEnemyLevel = 1
        
        addAdventurer(adventurerName: newAdventurerName, profession: newAdventurerProfession, level: newAdventurerLevel, attackModifier: newAdventurerAttack, currentHitPoints: newAdventurerCurrentHP, totalHitPoints: newAdventurerTotalHP, portrait: newAdventurerPortrait, defense: newAdventurerDefence, speed: newAdventurerSpeed, enemiesDefeated: newEnemiesDefeated, enemyName: newEnemyName, enemyAttack: newEnemyAttack, enemyDefense: newEnemyDefense, enemyCurrentHitPoints: newEnemyCurrentHP, enemyTotalHitPoints: newEnemyTotalHP, enemyLevel: newEnemyLevel)
        //             addAdventurer(adventurerName: newAdventurerName, profession: newAdventurerProfession, level: newAdventurerLevel, attackModifier: newAdventurerAttack, currentHitPoints: newAdventurerCurrentHP, totalHitPoints: newAdventurerTotalHP, portrait: newAdventurerPortrait, defense: newAdventurerDefence, speed: newAdventurerSpeed, enemiesDefeated: newEnemiesDefeated, enemyName: newEnemyName)
        tableView.reloadData()
        
    }
    
    @IBAction func endQuest(segue:UIStoryboardSegue) {
        //        let recruitmentVC = segue.source as! QuestViewController
        tableView.reloadData()
        let questVC = segue.source as! QuestViewController
        let timer = questVC.timer
        timer.invalidate()
        
    }
    
    func addAdventurer(adventurerName: String, profession: String, level: Int, attackModifier: Float, currentHitPoints: Int, totalHitPoints: Int, portrait: String, defense: Float, speed: Int, enemiesDefeated: Int, enemyName: String, enemyAttack: Float, enemyDefense: Float, enemyCurrentHitPoints: Int, enemyTotalHitPoints: Int, enemyLevel: Int) {
        
        //
        //    func addAdventurer(adventurerName: String, profession: String, level: Int, attackModifier: Float, currentHitPoints: Int, totalHitPoints: Int, portrait: String, defense: Float, speed: Int, enemiesDefeated: Int, enemyName: String) {
        //
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return os_log("error accessing AppDelegate")
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let adventurerEntity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
        
        
        
        let adventurer = NSManagedObject(entity: adventurerEntity, insertInto: managedContext)
        
        
        adventurer.setValue(adventurerName, forKey: "name")
        adventurer.setValue(profession, forKey: "profession")
        adventurer.setValue(level, forKey: "level")
        adventurer.setValue(attackModifier, forKey: "attackModifier")
        adventurer.setValue(currentHitPoints, forKey: "currentHitPoints")
        adventurer.setValue(totalHitPoints, forKey: "totalHitPoints")
        adventurer.setValue(portrait, forKey: "portrait")
        adventurer.setValue(defense, forKey: "defenseModifier")
        adventurer.setValue(speed, forKey: "speed")
        adventurer.setValue(enemiesDefeated, forKey: "enemiesDefeated")
        adventurer.setValue(enemyName, forKey: "enemyName")
        
        let enemyEntity = NSEntityDescription.entity(forEntityName: "Enemy", in: managedContext)!
        
        let enemy = NSManagedObject(entity: enemyEntity, insertInto: managedContext)
        
        enemy.setValue(enemyName, forKey: "name")
        enemy.setValue(enemyAttack, forKey: "attackModifier")
        enemy.setValue(enemyDefense, forKey: "defenseModifier")
        enemy.setValue(enemyCurrentHitPoints, forKey: "currentHitPoints")
        enemy.setValue(enemyTotalHitPoints, forKey: "totalHitPoints")
        enemy.setValue(adventurerName, forKey: "adventurerName")
        
        
        do {
            try managedContext.save()
            adventurers.append(adventurer)
        } catch let error as NSError {
            print("Could not add adventurer. \(error), \(error.userInfo)")}
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Quest") {
            guard let questViewController = segue.destination as?
                QuestViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedAdventurerCell = sender as? AdventurerTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedAdventurerCell) else {
                fatalError("The selected cell is not being displated by the table")
            }
            
            let selectedAdventurer = adventurers[indexPath.row]
            questViewController.adventurer = selectedAdventurer
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        
    }
    
}
