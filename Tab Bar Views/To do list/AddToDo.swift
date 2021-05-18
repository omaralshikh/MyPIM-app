//
//  AddToDo.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct AddToDo: View {
    
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
    let task = ["Yes", "No"]
    
        
    var body: some View {
        Form {
        Section(header: Text("task title")) {
            HStack {
            TextField("Enter task title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            }
            .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

        }
        
        Section(header: Text("task description")) {
            HStack {
            TextField("Enter description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
            }
            .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

        }
        
        Section(header: Text("task priority level")) {
            Picker("", selection: $selectedIndex) {
                ForEach(0 ..< priorityLevel.count, id: \.self) { index in
                   Text(self.priorityLevel[index]).tag(index)
               }
            }
            .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

        }
            
            Section(header: Text("task completed")) {
                Picker("", selection: $selectedIndex2) {
                    ForEach(0 ..< task.count, id: \.self) { index in
                       Text(self.task[index]).tag(index)
                   }
                }
                .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            
            Section(header: Text("task due date and time")) {
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
                if self.inputDataValidated() {
                    self.addNewTask()
                    self.showTaskAddedAlert = true
                } else {
                    self.showMissingInputDataAlert = true
                }
            }) {
                Image(systemName: "plus")
        })
    } // body
    
    var taskAddedAlert: Alert {
        Alert(title: Text("task Added!"),
              message: Text("New task is added to your to do list."),
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
        
        userData.ListStruct.append(newTask)
        ListStructList = userData.ListStruct
        
        userData.sortedLists[0].append(newTask)
        userData.sortedLists[1].append(newTask)
        userData.sortedLists[2].append(newTask)
        // Dismiss this View and go back
        createSortedList()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddToDo_Previews: PreviewProvider {
    static var previews: some View {
        AddToDo()
    }
}
