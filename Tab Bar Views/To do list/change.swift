//
//  change.swift
//  MyPIM
//
//  Created by Omar on 10/20/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct change: View {
    var task: ListStruct
    //var higherPresentationMode : PresentationMode
    
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    @State private var showMissingInputDataAlert = false
    @State private var title = ""
    @State private var description = ""
    @State private var date = ""
    @State private var showTaskAddedAlert = false


    
    @State private var selectedIndex = 0
    @State private var selectedIndex2 = 0

    let priorityLevel = ["Low", "Normal", "High"]
    let taskCompleted = ["Yes", "No"]
    
    
    var body: some View {
        Form {
        Section(header: Text("change task title")) {
            Text(task.title)
            HStack {
            TextField("Enter task title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            }
            .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

        }
        
        Section(header: Text("change task description")) {
            Text(task.description)
            HStack {
            TextField("Enter description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            }
            .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

        }
        
        Section(header: Text("change task priority level")) {
            Text("Current Priority = " + task.priority)
            Picker("", selection: $selectedIndex) {
                ForEach(0 ..< priorityLevel.count, id: \.self) { index in
                   Text(self.priorityLevel[index]).tag(index)
               }
            }
            .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

        }
            
            Section(header: Text("change task completed")) {
                HStack{
                Text("Current Completed = ")
                    if (task.completed == true){
                        Text("Yes")
                    }
                    else {
                        Text("No")
                    }
                }
                Picker("", selection: $selectedIndex2) {
                    ForEach(0 ..< taskCompleted.count, id: \.self) { index in
                       Text(self.taskCompleted[index]).tag(index)
                   }
                }
                .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            
            Section(header: Text("change task due date and time")) {
                Text("Current Due Date and Time = " + task.dueDateAndTime)
                HStack {
                TextField("Enter due date and time", text: $date)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                }
            }
        
        
        } // from
        .font(.system(size: 14))
        .alert(isPresented: $showTaskAddedAlert, content: { self.taskAddedAlert })

        .navigationBarTitle(Text("Add Task"), displayMode: .inline)
        // Place the Add (+) button on right of the navigation bar
        .navigationBarItems(trailing:
            Button(action: {
               // if self.inputDataValidated() {
                    self.addNewTask()
                    self.showTaskAddedAlert = true
               // } else {
                   // self.showMissingInputDataAlert = true
                //}
            }) {
                Text("Save")
        })

    } // body
    
    var taskAddedAlert: Alert {
        Alert(title: Text("task changed!"),
              message: Text("task has been changed."),
              dismissButton: .default(Text("OK")) {
               
                // Dismiss this Modal View and go back to the previous view in the navigation hierarchy
                self.presentationMode.wrappedValue.dismiss()
              })
    }
    
    var missingInputDataAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("title and description are required. Default values are assumed for the others."),
              dismissButton: .default(Text("OK")) )
        /*
        Tapping OK resets @State var showMissingInputDataAlert to false.
        */
    }
    
    func inputDataValidated() -> Bool {
       
        if self.title.isEmpty || self.description.isEmpty {
            return false
        }
       
        return true
    }
    
    func addNewTask() {
        
        var complete = true
        if (selectedIndex2 == 1){
            complete = false
        }
       
        
        let newTask = ListStruct(id: UUID(), title: self.title, description: self.description, priority: priorityLevel[selectedIndex], completed: complete, dueDateAndTime: self.date)
        
        if let index = userData.ListStruct.firstIndex(of: task) {
            userData.ListStruct.remove(at: index)
            userData.ListStruct.append(newTask)
            ListStructList = userData.ListStruct
            createSortedList()
            userData.sortedLists[0] = sortedListTitle
            userData.sortedLists[1] = sortedListDueDate
            userData.sortedLists[2] = sortedListPriority
            
        }
        self.presentationMode.wrappedValue.dismiss()
    }
}
