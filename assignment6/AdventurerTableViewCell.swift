//
//  AdventurerTableViewCell.swift
//  assignment6
//
//  Created by Peter Vail Driscoll II on 4/4/20.
//  Copyright © 2020 group6. All rights reserved.
//

import UIKit

class AdventurerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adventurerPortrait: UIImageView!
    @IBOutlet weak var adventurerName: UILabel!
    @IBOutlet weak var adventurerLevel: UILabel!
    @IBOutlet weak var adventurerProfession: UILabel!
    @IBOutlet weak var adventurerAttack: UILabel!
    @IBOutlet weak var adventurerCurrentHP: UILabel!
    @IBOutlet weak var adventurerTotalHP: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
