//
//  Animal.swift
//  group6_assignment5
//
//  Created by Patricia Cabanilla on 3/1/20.
//  Copyright © 2020 Patricia Cabanilla. All rights reserved.
//

import Foundation

class Animal
{
    private var _name:String
    private var _scientificName:String
    private var _animalClass:String
    private var _size:String
    public var image:String
    
    public var name:String {
        get {
            return _name
        }
        set (newName) {
            self._name = newName
        }
    }
    
    public var scientificName:String {
        get {
            return _scientificName
        }
        set (newScientificName) {
            self._scientificName = newScientificName
        }
    }
    
    public var animalClass:String {
        get {
            return _animalClass
        }
        set (newAnimalClass) {
            self._animalClass = newAnimalClass
        }
    }
    
    public var size:String {
        get {
            return _size
        }
        set (newSize) {
            self._size = newSize
        }
    }
    
    init (name:String, scientificName:String, animalClass:String, size:String, image:String){
        self._name = name
        self._scientificName = scientificName
        self._animalClass = animalClass
        self._size = size
        self.image = image
    }
}
