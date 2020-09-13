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
    
    @EnvironmentObject var userData: UserData
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    var documents: [TaskCellViewModel] {
        documentNames.keys.sorted{
            documentNames[$0]! < documentNames[$1] ?? ""
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.taskCellViewModels = defaultTasks.map {task in
            TaskCellViewModel(task: task)
        }
    }
    
    func addTask(task: Task){
        let TaskVM = TaskCellViewModel(task: task)
        self.taskCellViewModels.append(TaskVM)
    }
    
    private func createTask(){
        let newTask = Task(title: "", completed: false)
        self.userData.tasks.insert(newTask, at: 0)
        
    }
    
    @Published private var documentNames = [TaskCellViewModel:String]()
    
    
    func removeTask(_ document: TaskCellViewModel){
        //_ = TaskCellViewModel(task: task)
        documentNames[document] = nil
    }
}

