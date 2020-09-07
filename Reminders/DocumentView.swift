//
//  DocumentView.swift
//  Reminders
//
//  Created by McKiba Williams on 9/5/20.
//  Copyright © 2020 McKiba Williams. All rights reserved.
//

import SwiftUI

struct DocumentView: View {
    @State var taskName: String = ""
    @ObservedObject var tasklistVM = TaskListViewModel()
    @EnvironmentObject var store: TaskListViewModel


    
    let model = testDataTask
    @State private var searchText: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                Spacer()
                Button(action: {},
                       label: { Text("Edit")
                }).padding()
            }
            SearchBar(text: $searchText, placeholder: "Search")
            
            VStack{
                HStack{
                    Today()
                    Spacer()
                    Scheduled()
                }
                All()
            }
            VStack(alignment: .leading){
                Text("My List").bold()
                List{
                    ForEach(tasklistVM.taskCellViewModels) { taskCellVM in
                       TaskView(taskCellVM: taskCellVM)
                    }.onDelete{ indexSet in
                        indexSet.map { self.store.documents[$0] }.forEach { document in
                            self.store.removeTask(document)
                        }
                    }
                }
            }.padding()
        }
    }
}
struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct Today : View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "calendar").resizable()
                    .accentColor(Color.blue)
                    .imageScale(.large)
                    .foregroundColor(Color.blue)
                    .frame(width: 35, height:35)
                Spacer()
                Text("0").bold()
            }
            Text("Today")
        }.padding()
    }
}
struct All : View {
    @State var showTasklist = true

    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                
                Image(systemName: "location").resizable()
                    .imageScale(.large)
                    .foregroundColor(Color.gray)
                    .frame(width: 35, height:35)
                    .onTapGesture {
                        self.showTasklist = true
                }.sheet(isPresented: $showTasklist){
                    ListView(isShowing: self.$showTasklist)
                }

                Spacer()
                Text("0").bold()
            }
            Text("All")
        }.padding()
    }
}
struct Scheduled : View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "clock").resizable()
                    .imageScale(.large)
                    .foregroundColor(Color.orange)
                    .frame(width: 35, height:35)
                Spacer()
                Text("0").bold()
            }
            Text("Scheduled")
        }.padding()
    }
}
struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView()
    }
}


