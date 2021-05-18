 //
//  ToDoList.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ToDoList: View {
    
    @State private var selectedIndex = 0
    let bar = ["Title", "Due Date", "Priority"]
    
    @EnvironmentObject var userData: UserData
    
    /*
     Picker("", selection: $selectedIndex) {
         ForEach(0 ..< bar.count, id: \.self) { index in
            Text(self.bar[index]).tag(index)
        }
     }
     .frame(minWidth: 300, maxWidth: 500, alignment: .center)
     .pickerStyle(SegmentedPickerStyle())
     .padding(.horizontal)
     */
    
    
    var body: some View {
        NavigationView {

            List {
                Picker("", selection: $selectedIndex) {
                    ForEach(0 ..< bar.count, id: \.self) { index in
                       Text(self.bar[index]).tag(index)
                   }
                }
                .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                ForEach(userData.sortedLists[selectedIndex]) { list in
                    NavigationLink(destination: ToDoDetails(task: list)
                                    ) {
                        ToDoItem(task: list)
                        
                    }
                }
                
              .onDelete(perform: delete)
              .onMove(perform: move)

          }   // End of List
               .navigationBarTitle(Text("To-Do List"), displayMode: .inline)

                // Place the Edit button on left of the navigation bar
           .navigationBarItems(leading: EditButton(), trailing:
                NavigationLink(destination: AddToDo()) {
                    Image(systemName: "plus")
                })
            
      }   // End of NavigationView
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
    }
   
    /*
     -----------------------------
     MARK: - Delete Selected Photo
     -----------------------------
     */
    func delete(at offsets: IndexSet) {
        /*
         'offsets.first' is an unsafe pointer to the index number of the array element
         to be deleted. It is nil if the array is empty. Process it as an optional.
         */
        if let index = offsets.first {

            let nameOfFileToDelete = userData.ListStruct[index].title

            // Obtain the document directory file path of the file to be deleted
            let filePath = documentDirectory.appendingPathComponent(nameOfFileToDelete).path

            do {
                let fileManager = FileManager.default

                // Check if the photo file exists in document directory
                if fileManager.fileExists(atPath: filePath) {
                    // Delete the photo file from document directory
                    try fileManager.removeItem(atPath: filePath)
                } else {
                    // Photo file does not exist in document directory
                }
            } catch {
                print("Unable to delete the task file from the document directory.")
            }

            // Remove the selected photo from the list
            userData.ListStruct.remove(at: index)

            // Set the global variable point to the changed list
            ListStructList = userData.ListStruct
            userData.sortedLists[0].remove(at: index)
            userData.sortedLists[1].remove(at: index)
            userData.sortedLists[2].remove(at: index)
            createSortedList()

        }
    }
   
    /*
     ---------------------------
     MARK: - Move Selected Photo
     ---------------------------
     */
    func move(from source: IndexSet, to destination: Int) {

        userData.ListStruct.move(fromOffsets: source, toOffset: destination)

        // Set the global variable point to the changed list
        ListStructList = userData.ListStruct
    }
}
struct ToDoList_Previews: PreviewProvider {
    static var previews: some View {
        ToDoList()
    }
}
