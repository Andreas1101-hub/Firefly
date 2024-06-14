//
//  Todo.swift
//  Firefly
//
//  Created by Kwong, Andreas (IRG) on 14/06/2024.
//

import Foundation
import FirebaseFirestore

struct Todo {
    let id: String
    let content: String
    let createdAt: Date
    
    init(id: String, data: [String: Any]) {
        self.id = id
        self.content = data["content"] as? String ?? "My todo"
        let timestamp = data["createdAt"] as? Timestamp ?? nil
        self.createdAt = timestamp?.dateValue() ?? Date()
    }
  
    init(id: String, content: String, createdAt: Date) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
    }
}
