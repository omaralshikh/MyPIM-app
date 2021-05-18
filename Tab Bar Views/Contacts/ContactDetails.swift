//
//  ContactDetails.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ContactDetails: View {
    let contact: Contacts
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                Text(contact.firstName + " " + contact.lastName)
            }
            
            Section(header: Text("photo")) {
                Image(contact.photoFullFilename.replacingOccurrences(of: ".jpg", with: ""))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Section(header: Text("Company Name")) {
                Text(contact.company)
            }
            Section(header: Text("phone number")) {
                HStack {
                Image(systemName: "phone.circle")
                Text(contact.phone)
                }
                
            }
            
            Section(header: Text("Email Address")) {
                HStack {
                Image(systemName: "envelope")
                    Text(contact.email)
                }
            }
            
            Section(header: Text("Postal address")) {
                Text(contact.addressLine1 + " " + contact.addressLine2)
                Text(contact.addressCity + ", " + contact.addressState + " " + contact.addressZipcode)
                Text(contact.addressCountry)
            }
        
        
        
        
        } // form
    }
}

struct ContactDetails_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetails(contact: ContactsStructList[0])
    }
}
