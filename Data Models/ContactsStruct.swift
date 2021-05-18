//
//  ContactsStruct.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct Contacts: Hashable, Codable, Identifiable {
    
    var id: UUID
    var firstName: String
    var lastName: String
    var photoFullFilename: String
    var company: String
    var phone: String
    var email: String
    var addressLine1: String
    var addressLine2: String
    var addressCity: String
    var addressState: String
    var addressZipcode: String
    var addressCountry: String
    
    
}
