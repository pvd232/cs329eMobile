//
//  Adventurer.swift
//  assignment6
//
//  Created by Peter Vail Driscoll II on 4/4/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit
import os.log

class Adventurer {
    
    // MARK: Props
    
    var name: String
    var profession: String
    var level: Int
    var currentHP: Int
    var totalHP: Int
    var attack: Float
    var portrait: UIImage
    
    init(Name: String, Profession: String, Level: Int, CurrentHP: Int, TotalHP: Int, Attack: Float, Portrait: UIImage){
        self.name = Name
        self.profession = Profession
        self.level = Level
        self.currentHP = CurrentHP
        self.totalHP = TotalHP
        self.attack = Attack
        self.portrait = Portrait
    }
    
}
