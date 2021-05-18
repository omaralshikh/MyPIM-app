//
//  ContactList.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ContactList: View {
    
    @EnvironmentObject var userData: UserData
    
    @State private var searchItem = ""
    //searchableOrderedContactList
   
    var body: some View {
        NavigationView {
            List {
                SearchBar(searchItem: $searchItem, placeholder: "Search Contacts")
                
                ForEach(userData.searchableOrderedContactList.filter {self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self)
                { aContact in
                    
                    NavigationLink(destination: ContactDetails(contact: self.searchContacts(searchListItem: aContact)))
                    {
                        
                        ContactItem(contact: self.searchContacts(searchListItem: aContact))
                    }
                }

                .onDelete(perform: delete)
                .onMove(perform: move)
               
            }   // End of List
                .navigationBarTitle(Text("Contacts"), displayMode: .inline)
               
                // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton(), trailing:
                                    NavigationLink(destination: AddContact()){
                    Image(systemName: "plus")
                })
        }   // End of NavigationView
            .customNavigationViewStyle()  // Given in NavigationStyle.swift
    }
    
    
    func searchContacts(searchListItem: String) -> Contacts {
        
        // Find the index number of cocktailList matching the cocktail attribute 'id'
        print(userData.ContactList)
        let index = userData.ContactList.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
       
        return userData.ContactList[index]
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
           
            let nameOfFileToDelete = userData.ContactList[index].photoFullFilename

            
           
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
            userData.ContactList.remove(at: index)
            userData.searchableOrderedContactList.remove(at: index)
           
            // Set the global variable point to the changed list
            ContactsStructList = userData.ContactList
            orderedSearchableContactList = userData.searchableOrderedContactList

        }
    }
   
    /*
     ---------------------------
     MARK: - Move Selected Photo
     ---------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
       
        userData.ContactList.move(fromOffsets: source, toOffset: destination)
        userData.searchableOrderedContactList.move(fromOffsets: source, toOffset: destination)

       
        // Set the global variable point to the changed list
        ContactsStructList = userData.ContactList
        orderedSearchableContactList = userData.searchableOrderedContactList

        
    }
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList()
    }
}
