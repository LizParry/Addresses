//
//  TableViewCell.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/6/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    var user: Users? {
        didSet {
            update()
        }
    }
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var suiteLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    func update() {
        guard let user = user else { return }
        //guard let address = address else { return }
        idLabel.text = "\(user.id)"
        nameLabel.text = user.name
        streetLabel.text = user.address.street
        suiteLabel.text = user.address.suite
        cityLabel.text = user.address.city
        zipcodeLabel.text = user.address.zipcode
        latLabel.text = user.address.geo.lat
        longitudeLabel.text = user.address.geo.lng
        
    }
    
}
