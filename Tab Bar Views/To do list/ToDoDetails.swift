//
//  ToDoDetails.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ToDoDetails: View {
    let task: ListStruct
//    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {

        Form {
            Section(header: Text("To-Do List Task Title")) {
                Text(task.title)
            }
            
            Section(header: Text("To-Do List Task Description")) {
                Text(task.description)
            }
            
            Section(header: Text("To-Do List Task Priority level")) {
                Text(task.priority)
            }
            
            Section(header: Text("To-Do List Task completed")) {
                if (task.completed == true){
                    Text("Yes")
                }
                else {
                    Text("No")
                }
            }
            Section(header: Text("To-Do List Task date and time")) {
                Text(task.dueDateAndTime)
            }
        } // form

        } // nav
        .customNavigationViewStyle()  // Given in NavigationStyle.swift
        .navigationBarItems(trailing:
                                NavigationLink(destination: change(task: task)) {
        Text("change")
        
    })
 
    }
    
}

struct ToDoDetails_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetails(task: ListStructList[0])
    }
}
