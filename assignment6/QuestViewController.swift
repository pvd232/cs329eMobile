//
//  QuestViewController.swift
//  assignment6
//
//  Created by Landry Luker on 4/10/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit
import CoreData
import os
class QuestViewController: UIViewController {
    
    var adventurer: NSManagedObject?
    var enemy: NSManagedObject?
    
    @IBOutlet weak var adventurerPortrait: UIImageView!
    @IBOutlet weak var adventurerNameLabel: UILabel!
    @IBOutlet weak var adventurerProfession: UILabel!
    @IBOutlet weak var adventurerAttack: UILabel!
    @IBOutlet weak var adventurerCurrentHP: UILabel!
    @IBOutlet weak var adventurerTotalHP: UILabel!
    @IBOutlet weak var questTextView: UITextView!
    @IBOutlet weak var adventurerLevel: UILabel!
    @IBOutlet weak var adventurerDefenseLabel: UILabel!
    @IBOutlet weak var adventurerSpeedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var timer = Timer()
    override func viewWillAppear(_ animated: Bool) {
        if let adventurer = adventurer {
            
            adventurerNameLabel.text = adventurer.value(forKeyPath: "name") as? String
            
            let level: Int = adventurer.value(forKeyPath: "level") as! Int
            adventurerLevel.text =  String(level)
            
            let speed: Int = adventurer.value(forKeyPath: "speed") as! Int
            adventurerSpeedLabel.text =  String(speed)
            
            adventurerPortrait.image = UIImage(named: adventurer.value(forKey: "portrait") as! String)
            
            adventurerProfession?.text = adventurer.value(forKeyPath: "profession") as? String
            
            let attack: Float = adventurer.value(forKey: "attackModifier") as! Float
            adventurerAttack.text = String(format: "%.2f", attack)
            
            let defense: Float = adventurer.value(forKey: "defenseModifier") as! Float
            adventurerDefenseLabel.text = String(format: "%.2f", defense)
            
            let currentHP: Int = adventurer.value(forKey: "currentHitPoints") as! Int
            adventurerCurrentHP.text = String(currentHP)
            
            let totalHP: Int = adventurer.value(forKey: "totalHitPoints") as! Int
            adventurerTotalHP.text = String(totalHP)
        }
        
        
        
        // get the enemy associated with the current adventurer
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let enemyName = adventurer!.value(forKeyPath: "enemyName") as! String
        let enemyFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Enemy")
        enemyFetch.predicate = NSPredicate(format: "name == %@", enemyName)
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(enemyFetch) as? [NSManagedObject]
            enemy = fetchedResults?.first
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    func addEnemy() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return os_log("error accessing AppDelegate")
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let enemyEntity = NSEntityDescription.entity(forEntityName: "Enemy", in: managedContext)!
        
        let newEnemy = NSManagedObject(entity: enemyEntity, insertInto: managedContext)
        
        let enemyNames :[String] = ["Charzard", "Snorlax", "Ditto", "Lucario", "Gyrados"]
        let newEnemyName = enemyNames[Int.random(in: 0 ... 4)]
        
        let newEnemyAttack = Float.random(in: 1.0 ... 5.0)
        let newEnemyDefense = Float.random(in: 1.0 ... 5.0)
        let newEnemyCurrentHP = Int.random(in: 80 ... 150)
        let newEnemyTotalHP = newEnemyCurrentHP
        let adventurerName = adventurer!.value(forKeyPath: "name") as? String
        let newEnemyLevel = 1
        
        newEnemy.setValue(newEnemyName, forKey: "name")
        newEnemy.setValue(newEnemyAttack, forKey: "attackModifier")
        newEnemy.setValue(newEnemyDefense, forKey: "defenseModifier")
        newEnemy.setValue(newEnemyCurrentHP, forKey: "currentHitPoints")
        newEnemy.setValue(newEnemyTotalHP, forKey: "totalHitPoints")
        newEnemy.setValue(adventurerName, forKey: "adventurerName")
        newEnemy.setValue(newEnemyLevel, forKey: "level")
        enemy = newEnemy
        appDelegate.saveContext()
        
    }
    
    func scrollTextViewToBottom(textView: UITextView) {
        if textView.text.count > 0 {
            let location = textView.text.count - 1
            let bottom = NSMakeRange(location, 1)
            textView.scrollRangeToVisible(bottom)
        }
    }
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //            let managedContext = appDelegate.persistentContainer.viewContext
    //            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Enemy")
    //            var fetchedResults:[NSManagedObject]? = nil
    //
    //            do {
    //                try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
    //            } catch {
    //                let nserror = error as NSError
    //                NSLog("Unable to fetch \(nserror), \(nserror.userInfo)")
    //                abort()
    //            }
    //
    //            if let results = fetchedResults {
    //                enemies = results
    //            }
    
    @objc func gameplay () {
        let name = adventurer!.value(forKeyPath: "name") as! String
        let attack: Float = adventurer!.value(forKey: "attackModifier") as! Float
        let defense: Float = adventurer!.value(forKey: "defenseModifier") as! Float
        let currentHP: Int = adventurer!.value(forKey: "currentHitPoints") as! Int
        let totalHP: Int = adventurer!.value(forKey: "totalHitPoints") as! Int
        let speed: Int = adventurer!.value(forKeyPath: "speed") as! Int
        let level: Int = adventurer!.value(forKeyPath: "level") as! Int
        let enemiesDefeated: Int = adventurer!.value(forKeyPath: "enemiesDefeated") as! Int
        
        
        let enemyName = enemy!.value(forKeyPath: "name") as! String
        let enemyAttack: Float = enemy!.value(forKey: "attackModifier") as! Float
        let enemyDefense: Float = enemy!.value(forKey: "defenseModifier") as! Float
        let enemyCurrentHP: Int = enemy!.value(forKey: "currentHitPoints") as! Int
        let enemyTotalHP: Int = enemy!.value(forKey: "totalHitPoints") as! Int
        let enemyLevel: Int = enemy!.value(forKey: "level") as! Int
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return os_log("error accessing AppDelegate")
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let gameNum = Float.random(in: 0.0 ... 4.0)
//
//        let textViewLength = questTextView.text.split(separator: "\n")
//        if (textViewLength.count > 10) {
//            questTextView.text = ""
//        }
        
        if (gameNum < 2)
            // if gameNum is less than two then the adventurer attacks
        {
            let damageNum = Float.random(in: 18.0 ... 24.0)
            let defenseMultiplier = enemyDefense/10
            let damage = damageNum * attack * defenseMultiplier
            let roundedDamage = Int(damage)
            let newEnemyCurrentHP = enemyCurrentHP - roundedDamage
            
            // if enemy dies
            if (newEnemyCurrentHP < 0) {
                let newEnemiesDefeated = enemiesDefeated + 1
                adventurer?.setValue(newEnemiesDefeated, forKey: "enemiesDefeated")
                appDelegate.saveContext()
                
                // if adventurer has killed 5 enemies
                if (newEnemiesDefeated >= 5) {
                    questTextView.text += "\(name) has defeated \(enemyName) and won the game!\n"
                    scrollTextViewToBottom(textView: questTextView)
                    adventurer?.setValue(totalHP, forKey: "currentHitPoints")
                    adventurer?.setValue(0, forKey: "enemiesDefeated")
                    appDelegate.saveContext()
                    timer.invalidate()
                    //                    return
                }
                else {
                    // level up if you kill an enemy
                    let newLevel = level + 1
                    adventurerLevel.text = String(newLevel)
                    adventurer?.setValue(newLevel, forKey: "level")
                    questTextView.text += "\(name) has defeated \(enemyName) and leveled up to level \(newLevel)!\n"
                    scrollTextViewToBottom(textView: questTextView)
                    
                
                    adventurer?.setValue(totalHP, forKey: "currentHitPoints")
                    adventurerCurrentHP.text = String(totalHP)
                    appDelegate.saveContext()
                    questTextView.text += "\(name) has replenished hit points!\n"
                    scrollTextViewToBottom(textView: questTextView)
                    managedContext.delete(enemy!)
                    
                    addEnemy()
                    
                    let newEnemyName = enemy!.value(forKeyPath: "name") as! String
                    adventurer?.setValue(newEnemyName, forKey: "enemyName")
                    adventurer?.setValue(newEnemiesDefeated, forKey: "enemiesDefeated")
                    appDelegate.saveContext()
                    questTextView.text += "\(name) has defeated \(enemyName) and now must defeat \(newEnemyName).\n"
                    scrollTextViewToBottom(textView: questTextView)
                }
            }
            else {
                enemy?.setValue(newEnemyCurrentHP, forKey: "currentHitPoints")
                appDelegate.saveContext()
                questTextView.text += "\(name) has attacked \(enemyName) with a powerful blow. \(enemyName) loses \(roundedDamage) hit points!\n"
                scrollTextViewToBottom(textView: questTextView)
            }
        }
            // enemy attacks adventurer
        else {
            let scwifty = Int.random(in: 0 ... 10)
            
            // if adventurer speed less than this random integer then you adventurer gets attacked by enemy
            if (speed < scwifty) {
                let damageNum = Float.random(in: 18.0 ... 24.0)
                let defenseMultiplier = defense/10
                let damage = damageNum * enemyAttack * defenseMultiplier
                let roundedDamage = Int(damage)
                let newAdventurerCurrentHP = currentHP - roundedDamage
                
                // adventurer died
                if (newAdventurerCurrentHP < 0) {
                    let newEnemyLevel = enemyLevel + 1
                    questTextView.text += "\(name)'s has suffered a fatal blow.\n"
                    scrollTextViewToBottom(textView: questTextView)
                    questTextView.text += "\(enemyName) mocks \(name) and levels up to level \(newEnemyLevel).\n"
                    scrollTextViewToBottom(textView: questTextView)
                    questTextView.text += "\(name)'s currentHP is below 0. Game over."
                    scrollTextViewToBottom(textView: questTextView)
                    adventurer?.setValue(totalHP, forKey: "currentHitPoints")
                    adventurerCurrentHP.text = String(0)
                    enemy?.setValue(newEnemyLevel, forKey: "level")
                    appDelegate.saveContext()
                    timer.invalidate()
                    //                    return
                    
                }
                else {
                    adventurer?.setValue(newAdventurerCurrentHP, forKey: "currentHitPoints")
                    questTextView.text += "\(enemyName) has attacked \(name) with a powerful blow. \(name) loses \(roundedDamage) hit points!\n"
                    scrollTextViewToBottom(textView: questTextView)
                    adventurerCurrentHP.text = String(newAdventurerCurrentHP)
                    appDelegate.saveContext()
                }
            }
                // adventurer escapes attack
            else{
                questTextView.text += "\(name)'s speed is unmatched. \(name) dodged the attack!\n"
                scrollTextViewToBottom(textView: questTextView)
            }
            
        }
    }

override func viewDidAppear(_ animated: Bool) {
    let enemyName = adventurer!.value(forKeyPath: "enemyName") as! String
    questTextView.text += "Beginning Quest...\n"
    scrollTextViewToBottom(textView: questTextView)
    questTextView.text += "You will travel through the Old Forest to reach Minas Tirith.\n"
    scrollTextViewToBottom(textView: questTextView)
    questTextView.text += "You have encountered a wild \(enemyName).\n"
    scrollTextViewToBottom(textView: questTextView)
    timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(gameplay), userInfo: nil, repeats: true)
}
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



