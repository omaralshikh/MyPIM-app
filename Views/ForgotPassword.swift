//
//  ForgotPassword.swift
//  MyPIM
//
//  Created by Omar on 10/20/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ForgotPassword: View {
    
    @State private var showPassword = false
    @State private var EnterPassword = ""
    
    
    var body: some View {
        //   NavigationView{
            Form {
                Section(header: Text("show/hide entered values")){
                    HStack  {
                        
                        Toggle(isOn: $showPassword){
                            Text("show entered values")
                        }
                    } // hstack
                }
                Section(header: Text("security question")){
                    Text(myfunc())
                }
                
                Section(header: Text("enter answer to security question")){
                    HStack {
                        if self.showPassword {
                            TextField("Enter Answer", text: $EnterPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            
                            Button(action: {
                                
                                self.EnterPassword = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                        
                        else {
                            SecureField("Enter Answer", text: $EnterPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            Button(action: {
                                self.EnterPassword = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    .font(Font.title.weight(.regular))
                            }
                        } // else
                        
                    } // hstack
                }
                
                if (self.EnterPassword == UserDefaults.standard.string(forKey: "securityAnswer")) {
                    Section(header: Text("go to settings to reset password")) {
                        NavigationLink(destination: AnyView(Settings())) {
                            HStack {
                                Image(systemName: "gear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("show settings")
                                    .font(.system(size: 16))
                            }
                        }
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                }
                else {
                    Section(header: Text("Incorrect Answer")) {
                        Text("Answer to security question is incorrect")
                    }
                }
                
                
            } // form
     //   } // navigation View
        
        
        
    }
    
    func myfunc() -> String {
        
        
        return UserDefaults.standard.string(forKey: "securityQuestion") ?? "Unavailable"
    }
}
