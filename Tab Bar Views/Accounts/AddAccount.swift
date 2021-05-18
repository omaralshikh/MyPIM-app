//
//  AddAccount.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct AddAccount: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    @State private var showMissingInputDataAlert = false
    @State private var title = ""
    @State private var url = ""
    @State private var user = ""
    @State private var password = ""
    @State private var note = ""
    @State private var showAccountAddedAlert = false
    @State private var showPassword = false




    
    let categories = ["Email", "Bank", "Computer", "Other", "Membership", "Shopping", "CreditCard"]
    @State private var selectedIndex = 3


    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            Form {
                Section(header: Text("Select Account Category")) {
                    Picker("", selection: $selectedIndex) {
                        ForEach(0 ..< categories.count, id: \.self) {
                            Text(self.categories[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                }
                
                Section(header: Text("Account Title")) {
                    HStack {
                    TextField("Enter Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    
                    Button(action: {
                        self.title = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                            .font(Font.title.weight(.regular))
                    }
                    } // hstack
                }
                Section(header: Text("Account url")) {
                    HStack {
                    TextField("Enter Title", text: $url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    
                    Button(action: {
                        self.url = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                    } // hstack
                }
                Section(header: Text("Account username")) {
                    HStack {
                    TextField("Enter Title", text: $user)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    
                    Button(action: {
                        self.user = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                            .font(Font.title.weight(.regular))
                    }
                    } // hstack
                    .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

                }
                
                Section(header: Text("Account password")) {
                    HStack {
                        if self.showPassword {

                        
                    TextField("Enter Title", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        } else {
                            SecureField("Enter Title", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                        }
                    Button(action: {
                        self.showPassword.toggle()
                    }) {
                        Image(systemName: self.showPassword ? "eye" : "eye.fill") 
                            .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                            .font(Font.title.weight(.regular))
                    }
                    } // hstack
                    .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

                }
                Section(header: Text("Account Notes")) {
                    TextField("Enter note here", text: $note)
                        .disableAutocorrection(true)                }
            } // form
            } // z
        } // nav
        .font(.system(size: 14))
        .alert(isPresented: $showAccountAddedAlert, content: { self.AccountAddedAlert })
        .navigationBarTitle(Text("New Account"), displayMode: .inline)
        // Place the Add (+) button on right of the navigation bar
        .navigationBarItems(trailing:
            Button(action: {
                if self.inputDataValidated() {
                    self.addNewAccount()
                    self.showAccountAddedAlert = true
                } else {
                    self.showMissingInputDataAlert = true
                }
            }) {
                Image(systemName: "plus")
        })
            }
    
    var AccountAddedAlert: Alert {
        Alert(title: Text("New Account Added!"),
              message: Text("New Account is added to your Accounts list."),
              dismissButton: .default(Text("OK")) {
               
                // Dismiss this Modal View and go back to the previous view in the navigation hierarchy
                self.presentationMode.wrappedValue.dismiss()
              })
    }
    
    var missingInputDataAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("username and password are required. Default values are assumed for the others."),
              dismissButton: .default(Text("OK")) )
        /*
        Tapping OK resets @State var showMissingInputDataAlert to false.
        */
    }
    func inputDataValidated() -> Bool {
       
        if self.user.isEmpty || password.isEmpty {
            return false
        }
       
        return true
    }
    
    func addNewAccount() {
        
        let newAccount = Accounts(id: UUID(), title: self.title, category: self.categories[selectedIndex], url: self.url, username: self.user, password: self.password, notes: self.note)
        
        userData.AccountsList.append(newAccount)
        AccountStructList = userData.AccountsList
        // Dismiss this View and go back
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddAccount()
    }
}
