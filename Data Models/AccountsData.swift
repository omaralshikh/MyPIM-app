//
//  AccountsData.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import Foundation
import SwiftUI
 
// Global array of Account structs
var AccountStructList = [Accounts]()
 
/*
 *********************************
 MARK: - Read Accounts Data Files
 *********************************
 */
public func readAccountDataFiles() {
   
    var documentDirectoryHasFiles = false
    let AccountsDataFullFilename = "AccountsData.json"
   
    // Obtain URL of the AccountsData.json file in document directory on the user's device
    // Global constant documentDirectory is defined in UtilityFunctions.swift
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(AccountsDataFullFilename)
 
    do {
        /*
         Try to get the contents of the file. The left hand side is
         suppressed by using '_' since we do not use it at this time.
         Our purpose is just to check to see if the file is there or not.
         */
 
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
       
        /*
         If 'try' is successful, it means that the AccountsData.json
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
         Load it from Document Directory into AccountStructList.
         */
       
        // The function is given in UtilityFunctions.swift
        AccountStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: AccountsDataFullFilename, fileLocation: "Document Directory")
        print("AccountsData is loaded from document directory")
       
    } catch {
        documentDirectoryHasFiles = false
       
        /*
         ----------------------------------------------------
         |   The app is being launched for the first time   |
         ----------------------------------------------------
         The CocktailsData.json file does not exist in document directory on the user's device.
         Load it from main bundle (project folder) into AccountStructList.
        
         This catch section will be executed only once when the app is launched for the first time
         since we write and read the files in document directory on the user's device after first use.
         */
       
        // The function is given in UtilityFunctions.swift
        AccountStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: AccountsDataFullFilename, fileLocation: "Main Bundle")
        print("AccountsData is loaded from main bundle")
       
       
    }   // End of do-catch
}
 
/*
 ********************************************************
 MARK: - Write Accounts Data Files to Document Directory
 ********************************************************
 */
public func writeAccountsDataFiles() {
    /*
    --------------------------------------------------------------------------
    Write cocktailStructList into AccountsData.json file in Document Directory
    --------------------------------------------------------------------------
    */
   
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("AccountsData.json")
 
    // Encode AccountsStructList into JSON and write it into the JSON file
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(AccountStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded Accounts data to document directory!")
        }
    } else {
        fatalError("Unable to encode Accounts data!")
    }
}
