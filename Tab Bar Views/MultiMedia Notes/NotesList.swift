//
//  NotesList.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct NotesList: View {
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.NotesList) { aNote in
                    NavigationLink(destination: NotesDetails(note: aNote)) {
                        NotesItem(note: aNote)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
                .navigationBarTitle(Text("Photo Album"), displayMode: .inline)
               
                // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton(), trailing:
                NavigationLink(destination: AddNote()) {
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
           
            let nameOfFileToDelete = userData.NotesList[index].photoFullFilename
           
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
                print("Unable to delete the photo file from the document directory.")
            }
           
            // Remove the selected photo from the list
            userData.NotesList.remove(at: index)
           
            // Set the global variable point to the changed list
            NotesStructList = userData.NotesList
        }
    }
   
    /*
     ---------------------------
     MARK: - Move Selected Photo
     ---------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
       
        userData.NotesList.move(fromOffsets: source, toOffset: destination)
       
        // Set the global variable point to the changed list
        NotesStructList = userData.NotesList
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList()
    }
}
