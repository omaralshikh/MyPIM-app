//
//  Settings.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    @State private var EnterPassword = ""
    @State private var VerifyPassword = ""
    @State private var ans = ""
    @State private var showPassword = false
    @State private var showUnmatch = false
    @State private var passwordSet = false
    
    @State private var SelectedIndexFrom = 0
    @State private var SelectedIndex = 1
    
    let secuirtyQuestion = ["in what city or own did your mother and father meet?", "in what city or town were you born?", "what did you want to be when you grew up?", "what do you remember most from your childhood", "what is the name of the boy or girl that you fist kissed?", "what is the name of the first school you attended", "what is the name of your favorite childhood friend", "what is name of your first pet", "what is your mother's maiden name?", "what was your favorite place to visit as a child"]
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("show/hide entered values")){
                    HStack  {
                        
                        Toggle(isOn: $showPassword){
                            Text("show entered values")
                        }
                    } // hstack
                }
                Section(header: Text("select a security question")){
                    Picker("Selected:", selection: $SelectedIndexFrom) {
                        ForEach(0 ..< secuirtyQuestion.count, id: \.self){
                            Text(secuirtyQuestion[$0])
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500)
                }
                
                Section(header: Text("Enter Answer to selected Security Questions")){
                    HStack {
                        if self.showPassword {
                            TextField("Enter Answer", text: $ans)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                            
                            
                            Button(action: {
                              
                                self.ans = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                        
                        else {
                            SecureField("Enter Answer", text: $ans)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            Button(action: {
                                self.ans = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    .font(Font.title.weight(.regular))
                            }
                        } // else
                        
                    } // hstack
 
                }

                
                Section(header: Text("Enter Password")){
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
                
                Section(header: Text("Verify Password")){
                    HStack {
                        if self.showPassword {
                            TextField("Enter Answer", text: $VerifyPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            
                            Button(action: {
                                self.VerifyPassword = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    .font(Font.title.weight(.regular))
                            }
                        }
                        
                        else {
                            SecureField("Enter Answer", text: $VerifyPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            Button(action: {
                                self.VerifyPassword = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    .font(Font.title.weight(.regular))
                            }
                        } // else
                        
                    } // hstack
 
                }
                
                
                Section(header: Text("Set Password")){
                    Button(action: {
                        if !EnterPassword.isEmpty {
                            if EnterPassword == VerifyPassword {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                // Store the password in the user’s defaults database under the key "Password"
                                UserDefaults.standard.set(self.ans, forKey: "securityAnswer")
                                UserDefaults.standard.set(secuirtyQuestion[SelectedIndexFrom], forKey: "securityQuestion")
                                UserDefaults.standard.set(self.EnterPassword, forKey: "Password")
                               
                                self.EnterPassword = ""
                                self.VerifyPassword = ""
                                self.passwordSet = true
                            } else {
                                self.showUnmatch = true
                            }
                        }
                    }) {
                        Text("Set Password to Unlock App")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    .alert(isPresented: $showUnmatch, content: { self.unmatchedPasswordAlert })
                }
            } // form
            .navigationBarTitle(Text("Settings"), displayMode: .inline)

        } // nav view
    }
    /*
     --------------------------
     MARK: - Password Set Alert
     --------------------------
     */
    var passwordSetAlert: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) )
    }
   
    /*
     --------------------------------
     MARK: - Unmatched Password Alert
     --------------------------------
     */
    var unmatchedPasswordAlert: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")) )
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
