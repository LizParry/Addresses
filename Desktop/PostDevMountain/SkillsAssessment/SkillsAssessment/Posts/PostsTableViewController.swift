//
//  PostsTableViewController.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var user: Users?
    var posts: [Posts] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = user?.id
        PostsController.getPostsByID(number: (userID!), completion: { (true) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let userID = user?.id
        PostsController.getPostsByID(number: (userID!), completion: { (true) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
    }
    @IBAction func alphabetizeTapped(_ sender: Any) {
        PostsController.alphabetizeAZ()
        tableView.reloadData()
    }
    @IBAction func alphabetizeZATapped(_ sender: Any) {
        PostsController.alphabetizeZA()
        tableView.reloadData()
        
    }
    
    @IBAction func addPost(_ sender: Any) {
        let alertController = UIAlertController(title: "Add a new post", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (titleTextField) in
            titleTextField.placeholder = "Enter title here"
        }
        alertController.addTextField { (bodyTextField) in
            bodyTextField.placeholder = "Enter the post here"
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let title = alertController.textFields?[0].text, !title.isEmpty,
                let body = alertController.textFields?[1].text, !body.isEmpty
                else {return}
            
            PostsController.addNewPost(title: title, body: body, userId: self.user!.id, completion: { (user) in
                guard let post = user else {return}
                PostsController.posts.append(post)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsController.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        let post = PostsController.posts[indexPath.row]
        cell.post = post
        return cell
    }
}
