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

class AnimalCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var AnimalCollectionView: UICollectionView!
    
    var animalPictures = [GalleryItem]()
    var tuataraPictures = [GalleryItem]()
    var giraffePictures = [GalleryItem]()
    var greenlandSharkPictures = [GalleryItem]()
    var polarBearPictures = [GalleryItem]()
    /* String identifier used to dynamically load cells into collection */
    let identifier = "AnimalCollectionCell"
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)

    override func viewDidLoad() {
        accessPhotoPlist()
        super.viewDidLoad()
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
        tuataraPictures = Array(animalPictures[0...2])
        polarBearPictures = Array(animalPictures[3...5])
        greenlandSharkPictures = Array(animalPictures[6...8])
        giraffePictures = Array(animalPictures[9...11])
    }
        
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AnimalPhotoCollectionViewCell
        
        if globalVar < 2 {
            
        let animalPhoto = greenlandSharkPictures[indexPath.row]
        cell.animalImageView?.image = UIImage(named: animalPhoto.image)
        cell.captionLabel.text = animalPhoto.caption
        return cell
            
        }
            
        else if globalVar < 4 {
            
            let animalPhoto = giraffePictures[indexPath.row]
                   cell.animalImageView?.image = UIImage(named: animalPhoto.image)
                   cell.captionLabel.text = animalPhoto.caption
                   return cell
        }
            
       else if globalVar < 6 {
                  
                  let animalPhoto = tuataraPictures[indexPath.row]
                         cell.animalImageView?.image = UIImage(named: animalPhoto.image)
                         cell.captionLabel.text = animalPhoto.caption
                         return cell
              }
        
        else  {
                   
                   let animalPhoto = polarBearPictures[indexPath.row]
                          cell.animalImageView?.image = UIImage(named: animalPhoto.image)
                          cell.captionLabel.text = animalPhoto.caption
                          return cell
               }
        
    }
    

    func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
      // 1
      switch kind {
      // 2
      case UICollectionView.elementKindSectionHeader:
        // 3
        guard
          let headerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind, withReuseIdentifier: "HeaderView",
                                                                            for: indexPath) as? CollectionHeaderView
          else {
            fatalError("Invalid view type") }

        return headerView

      case UICollectionView.elementKindSectionFooter:
        guard
            let footerView = collectionView.dequeueReusableSupplementaryView( ofKind: kind,
                                                                              withReuseIdentifier: "FooterView",
                                                                              for: indexPath) as? CollectionFooterView
            else {
              fatalError("Invalid view type") }

          return footerView
      default:
        assert(false, "Invalid element type")
        }
    }
    
    // MARK: - UICollection View Flow Layout Delegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      //2
        let image = UIImage(named: animalPictures[indexPath.row].image)
        let cellWidth = image!.size.width
        let cellHeight = image!.size.height
        
        let paddingSpace = sectionInsets.left * (2)
        let availableWidth = view.frame.width - paddingSpace
        
        var widthPerItem:CGFloat
        if availableWidth > cellWidth {
            widthPerItem = cellWidth
        } else {
            widthPerItem = availableWidth
        }
        
        let aspectRatio = cellHeight/cellWidth
        return CGSize(width: widthPerItem, height: (widthPerItem*aspectRatio))
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}


