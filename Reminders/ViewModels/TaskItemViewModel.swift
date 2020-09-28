//
//  TaskCellViewModel.swift
//  Reminders
//
//  Created by McKiba Williams on 9/4/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import Foundation
import Combine

class TaskItemViewModel: ObservableObject , Hashable ,Identifiable  {
    
    static func == (lhs: TaskItemViewModel, rhs: TaskItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    @Published var taskRepository = TaskRepository()
    let id = UUID.self
    
    private var name = "Task List"
    @Published var task: Task
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var ids =  ""
    @Published var completionStateIconName = ""
    private var cancellables = Set<AnyCancellable>()
    
    
    init(task : Task ) {
        self.task = task
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap {task in  
                task.id
            }
            .assign(to: \.ids, on: self)
            .store(in: &cancellables)
        
        $task
            .dropFirst() //drops first update
            .debounce(for: 0.8, scheduler: RunLoop.main)//Waits to make sure updates are sent when typing stops
            .sink {  task in
                self.taskRepository.updateTask(task)
            }
            .store(in: &cancellables)
    }
}

