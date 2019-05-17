//
//  UsersTableViewController.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    var users = [Users]()
    var user: Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UsersController.getUsers { (success) in
            if success {
                UsersController.getUsers(completion: { (true) in
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                })
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersController.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = UsersController.users[indexPath.row]
        cell.textLabel?.text = user.name
        
        return cell
    }
    
    // MARK: - Navigation
    
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //     }
    //
}
