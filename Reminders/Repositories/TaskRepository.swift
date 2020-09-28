//
//  TaskRepository.swift
//  Reminders
//
//  Created by McKiba Williams on 9/26/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class TaskRepository: ObservableObject {
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        
        let userId = Auth.auth().currentUser?.uid
        
        db.collection("Tasks")
            .order(by: "DateCreated")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot , error) in
                if let querySnapshot = querySnapshot {
                    self.tasks = querySnapshot.documents.compactMap { document in
                        do {
                            let x = try document.data(as: Task.self)
                            return x
                        }
                        catch {
                            print(error)
                        }
                        return nil
                    }
                }
            }
    }
    
    func addTask(_ task: Task){
        do{
            var addedTask = task
            
            addedTask.userId = Auth.auth().currentUser?.uid
            let _  = try  db.collection("Tasks").addDocument(from: addedTask)
        }catch{
            fatalError("Unable to encode Task: \(error.localizedDescription)")
        }
    }
    
    
    func updateTask(_ task: Task) {

        if let taskID = task.id {
            do{
                try db.collection("Tasks").document(taskID).setData(from: task)
            }
            catch {
                fatalError("Unable to encode Task: \(error.localizedDescription)")
            }
        }
    }
}
