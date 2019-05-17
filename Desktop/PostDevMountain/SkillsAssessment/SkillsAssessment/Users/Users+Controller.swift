//
//  Users+Controller.swift
//  SkillsAssessment
//
//  Created by Liz Parry on 10/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

import Foundation

struct Users: Decodable {
    let name: String
    let id: Int
    let address: Address
}
struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
struct Geo: Decodable {
    let lat: String
    let lng: String
}

class UsersController {
    static var users = [Users]()
    static var addresses = [Address]()
    static func getUsers(completion: @escaping (Bool) -> Void) {
        let baseURL = URL(string: "https://jsonplaceholder.typicode.com/users")
        
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
        } .resume()
    }
}
