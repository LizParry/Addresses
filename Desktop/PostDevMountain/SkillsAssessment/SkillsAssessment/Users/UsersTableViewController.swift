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
    static let shared = UsersTableViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        UsersController.getUsers { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersController.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        let user = UsersController.users[indexPath.row]
        cell.user = user
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PostsTableViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let selectedUser = UsersController.users[indexPath.row]
        destination.user = selectedUser
    }
    
}
