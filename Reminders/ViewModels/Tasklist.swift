//
//  Tasklist.swift
//  Reminders
//
//  Created by McKiba Williams on 9/4/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import Foundation
import Combine


class TaskListViewModel: ObservableObject {
    
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.taskCellViewModels = testDataTask.map {task in
            TaskCellViewModel(task: task)
        }
    }
    
    
    func addTask(task: Task){
        let TaskVM = TaskCellViewModel(task: task)
        self.taskCellViewModels.append(TaskVM)
    }
}

