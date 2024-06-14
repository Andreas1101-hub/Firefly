//
//  FirebaseManager.swift
//  Firefly
//
//  Created by Kwong, Andreas (IRG) on 14/06/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    func saveTodo(todo: String) {
        let newTodoRef = db.collection("todos").document()
        newTodoRef.setData([
            "content": todo,
            "createdAt": Date()
        ])
    }
    
    func getTodos(completion: @escaping ([Todo]?, Error?) -> Void) {
        db.collection("todos").getDocuments { QuerySnapshot, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, error)
            }
            else {
                guard let documents = QuerySnapshot?.documents else {
                    print("Error getting querySnapshot documents")
                    completion(nil, nil)
                    return
                }
                
                var todos: [Todo] = []
                for document in documents {
                    let id = document.documentID
                    let data = document.data()
                    let todo = Todo(id: id, data: data)
                    todos.append(todo)
                }
                completion(todos, nil)
            }
        }
    }
    
    func deleteTodo(id: String, completion: @escaping (Error?) -> Void) {
        db.collection("todos").document(id).delete { error in
            completion(error)
        }
    }
}
