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
 
    Task(title: "Analysis of Alorithms Assigment",completed: true),
    Task(title: "Adcance Programming Assigment",completed: true)

]
#endif
