//
//  Tasks.swift
//  Reminders
//
//  Created by McKiba Williams on 9/3/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//
import Combine
import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


struct Task: Identifiable , Codable ,Equatable  {
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var DateCreated: Timestamp?
    var userId: String?
    
    
    init(title: String , completed: Bool, DateCreated: Timestamp?){
        self.id = UUID().uuidString
        self.title = title
        self.completed = completed
        self.DateCreated = DateCreated
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newDocument = try? JSONDecoder().decode(Task.self, from: json!) {
            self = newDocument
        } else {
            return nil
        }
    }
}
