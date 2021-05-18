//
//  ContentView.swift
//  MyPIM
//
//  Created by Omar on 10/10/20.
//

import SwiftUI
 
struct ContentView : View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    var body: some View {
       
        if userData.userAuthenticated {
            return AnyView(MainView())
        } else {
            return AnyView(LoginView())
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
