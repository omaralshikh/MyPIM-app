//
//  ContactsData.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import Foundation
import SwiftUI


 
// Global array of contact structs
var ContactsStructList = [Contacts]()
var orderedSearchableContactList = [String]()


 
/*
 *********************************
 MARK: - Read cocktails Data Files
 *********************************
 */
public func readContactsDataFiles() {
   
    var documentDirectoryHasFiles = false
    let contactsDataFullFilename = "ContactsData.json"
   
    // Obtain URL of the ContactssData.json file in document directory on the user's device
    // Global constant documentDirectory is defined in UtilityFunctions.swift
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(contactsDataFullFilename)
 
    do {
        /*
         Try to get the contents of the file. The left hand side is
         suppressed by using '_' since we do not use it at this time.
         Our purpose is just to check to see if the file is there or not.
         */
 
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
       
        /*
         If 'try' is successful, it means that the CocktailsData.json
         file exists in document directory on the user's device.
         ---
         If 'try' is unsuccessful, it throws an exception and
         executes the code under 'catch' below.
         */
       
        documentDirectoryHasFiles = true
       
        /*
         --------------------------------------------------
         |   The app is being launched after first time   |
         --------------------------------------------------
         The CocktailsData.json file exists in document directory on the user's device.
         Load it from Document Directory into contactStructList.
         */
       
        // The function is given in UtilityFunctions.swift
        ContactsStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: contactsDataFullFilename, fileLocation: "Document Directory")
        print("ContactsData is loaded from document directory")
        
        for contact in ContactsStructList {
            let selectedContactsAttributesForSearch = "\(contact.id)|\(contact.firstName)|\(contact.lastName)|\(contact.company)|\(contact.addressLine1)|\(contact.addressCity)|\(contact.addressState)|\(contact.addressCountry)"

            orderedSearchableContactList.append(selectedContactsAttributesForSearch)

        }
       
    } catch {
        documentDirectoryHasFiles = false
       
        /*
         ----------------------------------------------------
         |   The app is being launched for the first time   |
         ----------------------------------------------------
         The ContactsData.json file does not exist in document directory on the user's device.
         Load it from main bundle (project folder) into cocktailStructList.
        
         This catch section will be executed only once when the app is launched for the first time
         since we write and read the files in document directory on the user's device after first use.
         */
       
        // The function is given in UtilityFunctions.swift
        ContactsStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: contactsDataFullFilename, fileLocation: "Main Bundle")
        print("ContactsData is loaded from main bundle")
       
        /*
         -------------------------------------------------------------
         |   Create global variable orderedSearchableContactsList   |
         -------------------------------------------------------------
         This list has two purposes:
        
            (1) preserve the order of countries according to user's liking, and
            (2) enable search of selected cocktail attributes by the SearchBar in FavoritesList.
        
        */
        for contact in ContactsStructList {
            let selectedContactsAttributesForSearch = "\(contact.id)|\(contact.firstName)|\(contact.lastName)|\(contact.company)|\(contact.addressLine1)|\(contact.addressCity)|\(contact.addressState)|\(contact.addressCountry)"
           
            orderedSearchableContactList.append(selectedContactsAttributesForSearch)
        }
       
    }   // End of do-catch
   

}
 
/*
 ********************************************************
 MARK: - Write cocktails Data Files to Document Directory
 ********************************************************
 */
public func writeContactDataFiles() {
    /*
    --------------------------------------------------------------------------
    Write contactStructList into CocktailsData.json file in Document Directory
    --------------------------------------------------------------------------
    */
   
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("ContactsData.json")
 
    // Encode contactStructList into JSON and write it into the JSON file
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(ContactsStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded contacts data to document directory!")
        }
    } else {
        fatalError("Unable to encode contact data!")
    }
   
    /*
    ------------------------------------------------------
    Write orderedSearchableContactList into a file named
     orderedSearchableContactList in Document Directory
    ------------------------------------------------------
    */
 
    // Obtain URL of the file in document directory on the user's device
    let urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("orderedSearchableContactList")
 
    /*
    Swift Array does not yet provide the 'write' function, but NSArray does.
    Therefore, typecast the Swift array as NSArray so that we can write it.
    */
   
    (orderedSearchableContactList as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
   
    /*
     The flag "atomically" specifies whether the file should be written atomically or not.
    
     If flag atomically is TRUE, the file is first written to an auxiliary file, and
     then the auxiliary file is renamed as orderedSearchableCocktailList.
    
     If flag atomically is FALSE, the file is written directly to orderedSearchableContactList.
     This is a bad idea since the file can be corrupted if the system crashes during writing.
    
     The TRUE option guarantees that the file will not be corrupted even if the system crashes during writing.
     */
}
 

 
 
