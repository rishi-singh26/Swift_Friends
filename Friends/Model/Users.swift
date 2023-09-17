//
//  Users.swift
//  Friends
//
//  Created by Rishi Singh on 17/09/23.
//

import Foundation

class Users: ObservableObject {
    @Published var users = [User]()
    
    func loadUsers() async {
        guard users.isEmpty else { return }

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedResp = try? decoder.decode([User].self, from: data) {
                DispatchQueue.main.async {
                    self.users = decodedResp;
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}
