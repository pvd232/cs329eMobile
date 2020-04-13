//
//  QuestViewController.swift
//  assignment6
//
//  Created by Landry Luker on 4/10/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit
import CoreData
class QuestViewController: UIViewController {
    
    var adventurer: NSManagedObject?
    var enemies = [NSManagedObject]()
    @IBOutlet weak var adventurerPortrait: UIImageView!
    @IBOutlet weak var adventurerNameLabel: UILabel!
    @IBOutlet weak var adventurerProfession: UILabel!
    @IBOutlet weak var adventurerAttack: UILabel!
    @IBOutlet weak var adventurerCurrentHP: UILabel!
    @IBOutlet weak var adventurerTotalHP: UILabel!
    @IBOutlet weak var questTextView: UITextView!
    @IBOutlet weak var adventurerLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if let adventurer = adventurer {
            
            adventurerNameLabel.text = adventurer.value(forKeyPath: "name") as? String
            
            let level: Int = adventurer.value(forKeyPath: "level") as! Int
            adventurerLevel.text =  String(level)
            
            adventurerPortrait.image = UIImage(named: adventurer.value(forKey: "portrait") as! String)
            
            adventurerProfession?.text = adventurer.value(forKeyPath: "profession") as? String
            
            let attack: Float = adventurer.value(forKey: "attackModifier") as! Float
            adventurerAttack.text = String(format: "%.2f", attack)
            
            let currentHP: Int = adventurer.value(forKey: "currentHitPoints") as! Int
            adventurerCurrentHP.text = String(currentHP)
            
            let totalHP: Int = adventurer.value(forKey: "totalHitPoints") as! Int
                       adventurerTotalHP.text = String(totalHP)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Enemy")
            var fetchedResults:[NSManagedObject]? = nil
            
            do {
                try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
            } catch {
                let nserror = error as NSError
                NSLog("Unable to fetch \(nserror), \(nserror.userInfo)")
                abort()
            }
            
            if let results = fetchedResults {
                enemies = results
            }
            
        }
    
    @objc func gameplay () {
        let num = Float.random(in: 1.0 ... 5.0)
        if (num < 3) {
            questTextView.text = "Hello"
        }
        else {
            questTextView.text = "World"
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(gameplay), userInfo: nil, repeats: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

