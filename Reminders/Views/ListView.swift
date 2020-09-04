//
//  ContentView.swift
//  Reminders
//
//  Created by McKiba Williams on 9/3/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import SwiftUI


struct ListView: View {
    
    @ObservedObject var tasklistVM = TaskListViewModel()
    let model = testDataTask
    @State var presentAddItem = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(tasklistVM.taskCellViewModels) { taskCellVM in
                        TaskView(taskCellVM: taskCellVM)
                    }
                    if(presentAddItem) {
                        TaskView(taskCellVM: TaskCellViewModel(task: Task(title: "" , completed: false))){ task in
                            self.tasklistVM.addTask(task: task)
                            self.presentAddItem.toggle()
                        }
                    }
                }
                Button(action: {self.presentAddItem.toggle()}) {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height:20)
                        Text("New task")
                    }
                }.padding()
            }.navigationBarTitle("Tasks")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct TaskView: View {
    
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    
    var body: some View {
        HStack{
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" :"circle" )
                .resizable()
                .frame(width: 20, height:20)
                
                .onTapGesture{
                    self.taskCellVM.task.completed.toggle()
            }
            
            TextField("Enter Task Tile", text: $taskCellVM.task.title , onCommit: {self.onCommit(self.taskCellVM.task)})
        }
    }
}
