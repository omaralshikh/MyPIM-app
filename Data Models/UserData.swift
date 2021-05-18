//
//  UserData.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import Combine
import SwiftUI
 
final class UserData: ObservableObject {
    /*
     ===============================================================================
     |                   Publisher-Subscriber Design Pattern                       |
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
     
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     SceneDelegate, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
    
     When a change occurs in UserData, every View subscribed to it is notified to re-render its View.
     */
   
    /*
     ---------------------------
     MARK: - Published Variables
     ---------------------------
     */
   
    @Published var AccountsList = AccountStructList
    @Published var NotesList = NotesStructList
    @Published var ContactList = ContactsStructList
    @Published var ListStruct = ListStructList
    @Published var sortedLists = [sortedListTitle, sortedListDueDate, sortedListPriority ];

    
    @Published var searchableOrderedContactList = orderedSearchableContactList

   
    // Publish if the user is authenticated or not
    @Published var userAuthenticated = false
   
}
 
 
