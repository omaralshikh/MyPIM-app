//
//  AccountsStruct.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct Accounts: Hashable, Codable, Identifiable {
    
    var id: UUID
    var title: String
    var category: String
    var url: String
    var username: String
    var password: String
    var notes: String
    
}
