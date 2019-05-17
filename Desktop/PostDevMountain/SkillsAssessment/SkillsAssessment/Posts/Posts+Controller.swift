//
//  Posts+Controller.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation
class Posts: Decodable {
    let body: String
    let title: String
    let userId: Int
    init(body: String, title: String, userId: Int) {
        self.body = body
        self.title = title
        self.userId = userId
    }
}

class PostsController: Decodable {
    static var posts = [Posts]()

    static func getPostsByID(number: Int, completion: @escaping (Bool) -> Void) {
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com/posts")
        guard let url = baseURL else {completion(false); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let postsQueryItem = URLQueryItem(name: "userId", value: "\(number)")
        
        components?.queryItems = [postsQueryItem]
        
        guard let requestURL = components?.url else {completion(false); return}
        print("requesturl \(requestURL)")
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("There was an error retrieving data: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else {completion(false); return}
            do {
                let posts = try JSONDecoder().decode([Posts].self, from: data)
                self.posts = posts
                completion(true)
                
            } catch {
                print("There was an error decoding the JSON: \(error.localizedDescription)")
                completion(false)
                return
            }
            }
            .resume()
    }
    static func alphabetizeAZ() {
        let sortedPosts = posts.sorted(by: { $0.title < $1.title})
        self.posts = sortedPosts
    }
    
    static func alphabetizeZA() {
        let sortedPosts = posts.sorted(by: { $0.title > $1.title})
        self.posts = sortedPosts
    }
    
    static func addNewPost(title: String, body: String, userId: Int, completion: @escaping (Posts?) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let newPost = Posts(body: body, title: title, userId: userId)
        let jsonDictionary = ["title" : newPost.title, "body" : newPost.body, "userId" : "\(newPost.userId)"]
        do {
            let jsonDictionaryAsData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
            request.httpBody = jsonDictionaryAsData
        } catch {
            print("there was an error turning the model object into a json dictionary: \(error.localizedDescription)")
            completion(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: request) {(_, _, error) in
            if let error = error {
                print("there was an error posting the data to server: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(newPost)
        }
        dataTask.resume()
    }
    
}




//3. Add functionality so that the user can create a new post by the user they have selected (POST https://jsonplaceholder.typicode.com/posts).
//    4. Add functionality so that the user can edit or delete a post (PUT or PATCH, DELETE https://jsonplaceholder.typicode.com/posts/{postId}).
