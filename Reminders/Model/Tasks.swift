//
//  Tasks.swift
//  Reminders
//
//  Created by McKiba Williams on 9/3/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import Foundation


struct Task: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var completed: Bool
}

#if DEBUG
let testDataTask = [
    Task(title: "Analysis of Algorithms Assignments ",completed: false),
    Task(title: "Advanced Programming Assignmnts",completed: false),
    Task(title: "ITPM  Assignmnts",completed: false)
]
#endif
