//
//  AddContact.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct AddContact: View {
    
    @EnvironmentObject var userData: UserData

    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedIndex = 0
    let cam = ["Camera", "Photo Library"]
    @State private var FirstName = ""
    @State private var LastName = ""
    @State private var Company = ""
    @State private var phone = ""
    @State private var Email = ""
    @State private var addy1 = ""
    @State private var addy2 = ""
    @State private var City = ""
    @State private var state = ""
    @State private var zip = ""
    @State private var country = ""
    @State private var photoImageData: Data? = nil
    @State private var showImagePicker = false
    @State private var showContactAddedAlert = false
    @State private var showMissingInputDataAlert = false



    
    var body: some View {
        Form {

        Section(header: Text("pick photo from photo library")) {
            Picker("", selection: $selectedIndex) {
                ForEach(0 ..< cam.count, id: \.self) { index in
                   Text(self.cam[index]).tag(index)
               }
            }
            .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            Button(action: {
                if(selectedIndex == 1 ){
                self.showImagePicker = true
                }
//                else if (selectedIndex == 0){
//                    self.showImagePicker = true
//                }
            }) {
            HStack {
            Image(systemName: "square.and.arrow.up.on.square")
                .imageScale(.large)
                .font(Font.title.weight(.regular))
                .foregroundColor(.blue)
            Text("Get Photo")
            }
            }

        }
            
        Section(header: Text("contact photo")) {
            if(photoImageData != nil ){
                getImageFromBinaryData(binaryData: self.photoImageData, defaultFilename: "DefaultContactPhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            }
            else{
                Image("DefaultContactPhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            }


        }
            
            Section(header: Text("First Name")) {
                HStack {
                TextField("Enter First Name", text: $FirstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.FirstName = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
                .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

            }
            
            Section(header: Text("Last Name")) {
                HStack {
                TextField("Enter Last Name", text: $LastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.LastName = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
                .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })

            }

            Section(header: Text("Company name")) {
                HStack {
                TextField("Enter Company Name", text: $Company)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.Company = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            
            Section(header: Text("phone number")) {
                HStack {
                Image(systemName: "phone.circle")
                TextField("Enter Phone Number", text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.phone = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            
            Section(header: Text("Email address")) {
                HStack {
                Image(systemName: "envelope")
                TextField("Enter Email Address", text: $Email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.Email = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            
            Section(header: Text("address Line 1")) {
                HStack {
                TextField("Enter address Line 1", text: $addy1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.addy1 = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            Group {
            Section(header: Text("address Line 2 (optional)")) {
                HStack {
                TextField("Enter address Line 2", text: $addy2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.addy2 = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            
            Section(header: Text("City name")) {
                HStack {
                TextField("Enter City Name", text: $City)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.City = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            Section(header: Text("state (optional for non usa addresses)")) {
                HStack {
                TextField("Enter State", text: $state)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.state = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            
            Section(header: Text("zip code")) {
                HStack {
                TextField("Enter Zip Code", text: $zip)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.zip = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            
            Section(header: Text("Country name")) {
                HStack {
                TextField("Enter Country Name", text: $country)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                Button(action: {
                    self.country = ""
                }) {
                    Image(systemName: "clear")
                        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                        .font(Font.title.weight(.regular))
                }
                } // hstack
            }
            

        } // group
        } // form
        

        .font(.system(size: 14))

        .alert(isPresented: $showContactAddedAlert, content: { self.AccountAddedAlert })
        .sheet(isPresented: self.$showImagePicker) {
            PhotoCaptureView(showImagePicker: self.$showImagePicker,
                             photoImageData: self.$photoImageData,
                             cameraOrLibrary: "Photo Library")
        }
    
//        .sheet(isPresented: self.$showImagePicker) {
//            PhotoCaptureView(showImagePicker: self.$showImagePicker,
//                             photoImageData: self.$photoImageData,
//                             cameraOrLibrary: "Camera")
//    }

        .navigationBarTitle(Text("New Account"), displayMode: .inline)
        // Place the Add (+) button on right of the navigation bar
        .navigationBarItems(trailing:
            Button(action: {
                if self.inputDataValidated() {
                    self.addNewAccount()
                    self.showContactAddedAlert = true
                } else {
                    self.showMissingInputDataAlert = true
                }
            }) {
                Image(systemName: "plus")
        })
      
            } // body
   
    var AccountAddedAlert: Alert {
        Alert(title: Text("Contact Added!"),
              message: Text("New Contact is added to your Contact list."),
              dismissButton: .default(Text("OK")) {
               
                // Dismiss this Modal View and go back to the previous view in the navigation hierarchy
                self.presentationMode.wrappedValue.dismiss()
              })
    }
    
    var missingInputDataAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("first and last name are required. Default values are assumed for the others."),
              dismissButton: .default(Text("OK")) )
        /*
        Tapping OK resets @State var showMissingInputDataAlert to false.
        */
    }
    
    func inputDataValidated() -> Bool {
       
        if self.FirstName.isEmpty || self.LastName.isEmpty {
            return false
        }
       
        return true
    }
    
    func addNewAccount() {
        let newFullFilename = UUID().uuidString + ".jpg"

        let newContact = Contacts(id: UUID(), firstName: self.FirstName, lastName: self.LastName, photoFullFilename: newFullFilename , company: self.Company, phone: self.phone, email: self.Email, addressLine1: self.addy1, addressLine2: self.addy2, addressCity: self.City, addressState: self.state, addressZipcode: self.zip, addressCountry: self.country)
//        let newContact = savephoto(id: UUID(), firstName: self.FirstName, lastName: self.LastName, photoFullFilename: newFullFilename , company: self.Company, phone: self.phone, email: self.Email, addressLine1: self.addy1, addressLine2: self.addy2, addressCity: self.City, addressState: self.state, addressZipcode: self.zip, addressCountry: self.country)
//                
        
        userData.ContactList.append(newContact)
        
        let selectedContactsAttributesForSearch = "\(newContact.id)|\(newContact.firstName)|\(newContact.lastName)|\(newContact.company)|\(newContact.addressLine1)|\(newContact.addressCity)|\(newContact.addressState)|\(newContact.addressCountry)"
       
        userData.searchableOrderedContactList.append(selectedContactsAttributesForSearch)
        
        orderedSearchableContactList = userData.searchableOrderedContactList
        ContactsStructList = userData.ContactList
        // Dismiss this View and go back
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

