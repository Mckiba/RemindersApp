//
//  TaskCellViewModel.swift
//  Reminders
//
//  Created by McKiba Williams on 9/4/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject , Hashable ,Identifiable  {
    
    static func == (lhs: TaskCellViewModel, rhs: TaskCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID.self
    
    /* init(id: UUID? = nil) {
     self.id = id ?? UUID()
     }*/
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    @Published var task: Task
    
    var ids =  ""
    @Published var completionStateIconName = ""
    private var cancellables = Set<AnyCancellable>()
    
    
    init(task : Task) {
        self.task = task
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
        }
        .assign(to: \.completionStateIconName, on: self)
        .store(in: &cancellables)
        
        $task
            .map {task in
                task.id
        }
        .assign(to: \.ids, on: self)
        .store(in: &cancellables)
        
    }
    
}
