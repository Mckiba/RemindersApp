//
//  Tasklist.swift
//  Reminders
//
//  Created by McKiba Williams on 9/4/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


class TaskListViewModel: ObservableObject {
    
    @Published var taskrepository = TaskRepository()
    @Published var items = [TaskItemViewModel]()
    
    
    var documents: [TaskItemViewModel] {
        documentNames.keys.sorted{
            documentNames[$0]! < documentNames[$1] ?? ""
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        taskrepository.$tasks.map { tasks in
            tasks.map { task in
                TaskItemViewModel(task: task)
            }
        }
        .assign(to: \.items, on: self)
        .store(in: &cancellable)
    }
    
    func addTask(task: Task){
        taskrepository.addTask(task)
      //  let TaskVM = TaskItemViewModel(task: task)
      //  self.items.append(TaskVM)
    }

    @Published private var documentNames = [TaskItemViewModel:String]()
    
    
    func removeTask(_ document: TaskItemViewModel){
        //_ = TaskCellViewModel(task: task)
        documentNames[document] = nil
    }
}

