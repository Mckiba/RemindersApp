//
//  Tasks.swift
//  Reminders
//
//  Created by McKiba Williams on 9/3/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import Foundation
import Combine


struct Task: Identifiable , Codable   {
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool
    
    
    init(title: String , completed: Bool){
        self.id = UUID().uuidString
        self.title = title
        self.completed = completed
    }
}
//Added User Data
final class UserData: ObservableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    
    @UserDefaultValue(key: "Tasks", defaultValue: defaultTasks)
    var tasks: [Task] {
        didSet {
            didChange.send(self)
        }
    }
}


#if DEBUG
let defaultTasks = [
    Task(title: "Analysis of Algorithms Assignments ",completed: false),
    Task(title: "Advanced Programming Assignments",completed: false),
    Task(title: "ITPM  Assignments",completed: false)
]
#endif
