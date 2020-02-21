//
//  StoriesTableViewController.swift
//  NewspaperExample
//
//  Created by Peter Driscoll on 2/19/20.
//  Copyright © 2020 Peter Driscoll. All rights reserved.
//

import UIKit

struct Headline {
    
    var id: Int
    var title: String
    var text : String
    var image : String
    
}

class HeadlineTableViewCell: UITableViewCell {

 
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var headlineImageView: UIImageView!
}

class StoriesTableViewController: UITableViewController {
    
    var headlines = [
        Headline(id: 1, title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: "Apple"),
        Headline(id: 2, title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non.", image: "Banana"),
        Headline(id: 3, title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc.", image: "Cantaloupe"),
    ]

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return headlines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! HeadlineTableViewCell
        
        let headline = headlines[indexPath.row]
        cell.headlineTitleLabel?.text = headline.title
        cell.headlineTextLabel?.text = headline.text
        cell.headlineImageView?.image = UIImage(named : headline.image)
        return cell
    }
    
}
