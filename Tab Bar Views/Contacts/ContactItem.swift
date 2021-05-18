//
//  ContactItem.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ContactItem: View {
    
    let contact: Contacts
    
    var body: some View {
        HStack {
            Image(contact.photoFullFilename.replacingOccurrences(of: ".jpg", with: ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)

            VStack(alignment: .leading) {
                Text(contact.firstName + " " + contact.lastName)
                Text(contact.addressCity + ", " + contact.addressState + ", " + contact.addressCountry)
                HStack {
                Image(systemName: "phone.circle")
                Text(contact.phone)
                }
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
           
        }   // End of HStack
    }
 }
struct ContactItem_Previews: PreviewProvider {
    static var previews: some View {
        ContactItem(contact: ContactsStructList[0])
    }
}
