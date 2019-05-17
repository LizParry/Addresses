//
//  PostTableViewCell.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/6/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    var post: Posts? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = "Title: \(post.title)"
        bodyLabel.text = "Post: \(post.body)"
        
    }

}
