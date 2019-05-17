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
    //let userID: Int
}
class PostsController: Decodable {
    static var posts = [Posts]()
    static var userIdNumber: Int?
    static func getPosts(completion: @escaping (Bool) -> Void) {
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com/posts")
        //      guard let url = baseURL else {completion(false); return}
        //      var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        //      let postsQueryItem = URLQueryItem(name: "posts", value: "\(posts)")
        //
        //      components?.queryItems = [postsQueryItem]
        //
        //      guard let requestURL = components?.url else {completion(false); return}
        //      print("requesturl \(requestURL)")
        URLSession.shared.dataTask(with: baseURL!) { (data, _, error) in
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
    //function above to get all posts. created function to test the posts generally speaking. started function below to query them by userID. Still working on this function.
    static func getPostsByID(completion: @escaping (Bool) -> Void) {
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com/posts")
        guard let url = baseURL else {completion(false); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let postsQueryItem = URLQueryItem(name: "userId", value: "\(userIdNumber)")
        
        components?.queryItems = [postsQueryItem]
        
        guard let requestURL = components?.url else {completion(false); return}
        print("requesturl \(requestURL)")
        URLSession.shared.dataTask(with: baseURL!) { (data, _, error) in
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
}





