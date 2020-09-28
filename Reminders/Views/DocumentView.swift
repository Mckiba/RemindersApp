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
    
        //let model = testDataTask
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
                HStack{
                    All()
                    Spacer()
                    Flagged()
                }
            }
            VStack(alignment: .leading){
                Text("My List").bold()
                List{
                    ForEach(tasklistVM.items) { items in
                        TaskView(items: items)
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
                ZStack{
                    Image(systemName: "calendar")
                        .modifier(CustomModifier())
                }
                Spacer()
                Text("0").bold()
            }
            Text("Today")
        }.padding()
    }
}
struct All : View {
    @State var showTasklist = true
    let tray = UIImage(systemName: "tray.circle.fill")
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack{
                    Image(systemName: "tray")
                        .modifier(CustomModifier())
                }
                Spacer()
                Text("0").bold()
            }
            Text("All")
            
        }.padding()
        .onTapGesture {
            self.showTasklist = true
        }.sheet(isPresented: $showTasklist){
            ListView(isShowing: self.$showTasklist)
        }
    }
}
struct Flagged : View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack{
                    Image(systemName: "flag")
                        .modifier(CustomModifier())
                }
                Spacer()
                Text("0").bold()
            }
            Text("Flagged")
        }.padding()
    }
}
struct Scheduled : View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack{
                    Image(systemName: "clock").modifier(CustomModifier())
                }
                Spacer()
                Text("0").bold()
            }
            Text("Scheduled")
        }.padding()
    }
}
struct CustomModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        return content
            .imageScale(.large)
            .foregroundColor(Color.orange)
            .frame(width: 35  ,height: 35)
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView()
    }
}


