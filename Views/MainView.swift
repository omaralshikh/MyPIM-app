//
//  MainView.swift
//  MyPIM
//
//  Created by Omar on 10/10/20.
//

import SwiftUI
 
struct MainView: View {
    var body: some View {
        TabView {
            NotesList()
                .tabItem {
                    Image(systemName: "doc.richtext")
                    Text("Notes")
                }
            ToDoList()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("To Do")
                }
            ContactList()
                .tabItem {
                    Image(systemName: "rectangle.stack.person.crop")
                    Text("Contacts")
                }
            AccountList()
                .tabItem {
                    Image(systemName: "key.icloud")
                    Text("Accounts")
                }
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
           
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}
 
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
 
