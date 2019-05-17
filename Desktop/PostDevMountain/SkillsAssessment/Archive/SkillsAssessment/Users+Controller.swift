//
//  Users+Controller.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation

class Users: Decodable {
    let name: String
    //let address: String
}
//prioritized name. Planned to return to do address at the end 

//class Address: Decodable, Users {
//    let street: String
//    let suite: String
//    let city: String
//    let zipcode: String
//}
class UsersController: Decodable {
    static var users = [Users]()
    
    static func getUsers(completion: @escaping (Bool) -> Void) {
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com/users")
//        guard let url = baseURL else {completion(false); return}
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
//        let usersQueryItem = URLQueryItem(name: "users", value: "\(users)")
//
//        components?.queryItems = [usersQueryItem]
//
//       guard let requestURL = components?.url else {completion(false); return}
//        print(url)
            URLSession.shared.dataTask(with: baseURL!) { (data, _, error) in
            if let error = error {
                print("There was an error retrieving data: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else {completion(false); return}
            do {
                let users = try JSONDecoder().decode([Users].self, from: data)
                self.users = users
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





