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
}
/*final class UserData: ObservableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    
    @UserDefaultValue(key: "Tasks", defaultValue: defaultTasks)
    var tasks: [Task] {
        didSet {
            didChange.send(self)
        }
    }
}*/
/*
#if DEBUG
let defaultTasks = [
    Task(title: "Analysis of Algorithms Assignments ",completed: false),
    Task(title: "Advanced Programming Assignments",completed: false),
    Task(title: "ITPM  Assignments",completed: false),
    Task(title: "Finish Creating Me ☹️",completed: false)

]
#endif
*/
