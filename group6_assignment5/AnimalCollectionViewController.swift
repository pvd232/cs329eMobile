//
//  AnimalCollectionViewController.swift
//  group6_assignment5
//
//  Created by Patricia Cabanilla on 3/4/20.
//  Copyright © 2020 Patricia Cabanilla. All rights reserved.
//

import UIKit

class GalleryItem {
    
    private var _image: String
    private var _caption: String
    
    public var image: String {
        get { return _image }
        set (newImage) { self._image = newImage }
    }
    
    public var caption: String {
        get { return _caption }
        set (newCaption) { self._caption = newCaption }
    }
    
    init(image: String, caption: String) {
        self._image = image
        self._caption = caption
    }
}

class AnimalCollectionViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var AnimalCollectionView: UICollectionView!
    
    var animalPictures = [GalleryItem]()
    
    /* String identifier used to dynamically load cells into collection */
    private let identifier = "AnimalCollectionCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        accessPhotoPlist()
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
    
    private func accessPhotoPlist() {
        let inputFile = Bundle.main.path(forResource: "Photo Plist", ofType: "plist")
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
    
        for input in inputDataArray as! [Dictionary<String, String>] {
            for (key, value) in input {
                animalPictures.append(GalleryItem(image: key, caption: value)) }
        }
    }
        
    /*func numberOfSections(in collectionView: UICollectionView) -> Int {
      return searches.count
    }*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimalCollectionCell", for: indexPath) as! AnimalPhotoCollectionViewCell
        
        let animalPhoto = animalPictures[indexPath.row]
        cell.backgroundColor = .black
        cell.animalImageView?.image = UIImage(named: animalPhoto.image)
        cell.captionLabel.text = animalPhoto.caption
        
        return cell
    }

    //MARK: UICollectionViewFlowLayout
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 20, left: 10, bottom: 20, right: 10)
    }

}
