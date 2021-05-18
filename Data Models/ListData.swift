//
//  ListData.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import Foundation
import SwiftUI
 
// Global array of list structs
var ListStructList = [ListStruct]()
var sortedListTitle = [ListStruct]()
var sortedListDueDate = [ListStruct]()
var sortedListPriority = [ListStruct]()



/*
 *********************************
 MARK: - Read lists Data Files
 *********************************
 */
public func readListDataFiles() {
   
    var documentDirectoryHasFiles = false
    let cocktailsDataFullFilename = "ToDoListData.json"
   
    // Obtain URL of the ToDoListData.json file in document directory on the user's device
    // Global constant documentDirectory is defined in UtilityFunctions.swift
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(cocktailsDataFullFilename)

    

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
         The ToDoListData.json file exists in document directory on the user's device.
         Load it from Document Directory into ListStructList.
         */
       
        // The function is given in UtilityFunctions.swift
        ListStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: cocktailsDataFullFilename, fileLocation: "Document Directory")
        print("ListsData is loaded from document directory")
       
    } catch {
        documentDirectoryHasFiles = false
       
        /*
         ----------------------------------------------------
         |   The app is being launched for the first time   |
         ----------------------------------------------------
         The ToDoListData.json file does not exist in document directory on the user's device.
         Load it from main bundle (project folder) into cocktailStructList.
        
         This catch section will be executed only once when the app is launched for the first time
         since we write and read the files in document directory on the user's device after first use.
         */
       
        // The function is given in UtilityFunctions.swift
        ListStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: cocktailsDataFullFilename, fileLocation: "Main Bundle")
        print("ListsData is loaded from main bundle")
       
        
       
    }   // End of do-catch
createSortedList()
    
}

public func createSortedList(){
sortedListTitle = ListStructList.sorted(by: { $0.title < $1.title })
sortedListDueDate = ListStructList.sorted(by: { $0.dueDateAndTime < $1.dueDateAndTime })
sortedListPriority = ListStructList.sorted(by: { $0.priority < $1.priority })
}
 
/*
 ********************************************************
 MARK: - Write Lists Data Files to Document Directory
 ********************************************************
 */
public func writeListDataFiles() {
    /*
    --------------------------------------------------------------------------
    Write cocktailStructList into ToDoListData.json file in Document Directory
    --------------------------------------------------------------------------
    */
   
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("ToDoListData.json")
 
    // Encode ListStructList into JSON and write it into the JSON file
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(ListStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded Lists data to document directory!")
        }
    } else {
        fatalError("Unable to encode Lists data!")
    }
 
}
