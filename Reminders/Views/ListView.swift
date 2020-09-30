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
    //    let model = testDataTask
    @Binding var isShowing: Bool
    @State var presentAddItem = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: -18) {
            Button(action: {
                self.isShowing.toggle()
            }, label: { Text("Back") }).padding()
            NavigationView {
                VStack(alignment: .leading){
                    List{
                        ForEach(tasklistVM.items) { items in
                            TaskView(items: items)
                        }
                        if(presentAddItem) {
                            TaskView(items: TaskItemViewModel(task: Task(title: "" , completed: false, DateCreated: nil))){ task in
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
}

struct TaskView: View {
    
    @ObservedObject var items: TaskItemViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack{
            Image(systemName: items.task.completed ? "checkmark.circle.fill" :"circle" )
                .resizable()
                .frame(width: 10, height:10)
                .onTapGesture{
                    self.items.task.completed.toggle()
                }
            TextField("Enter Task Tile", text: $items.task.title , onCommit: {self.onCommit(self.items.task)})
        }
    }
}
