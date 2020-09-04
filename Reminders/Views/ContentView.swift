//
//  ContentView.swift
//  Reminders
//
//  Created by McKiba Williams on 9/3/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import SwiftUI


struct ListView: View {
    
    let model = testDataTask
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(model){ item in
                    TaskView(task: item)
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
    
    let task: Task
    
    var body: some View {
        HStack{
            Image(systemName: task.completed ? "checkmark.circle.fill" :"circle" )
                .resizable()
                .frame(width: 20, height:20)
            Text(task.title)
        }
    }
}
