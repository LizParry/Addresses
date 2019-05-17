//
//  PostsTableViewController.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var posts = [Posts]()
    var post: Posts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PostsController.getPosts { (success) in
            if success {
                PostsController.getPosts(completion: { (true) in
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                })
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsController.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = PostsController.posts[indexPath.row]
        cell.textLabel?.text = post.body
        
        return cell
    }
    
    // MARK: - Navigation
    
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //     }
    //
}
