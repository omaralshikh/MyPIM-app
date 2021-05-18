//
//  ListStruct.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ListStruct: Hashable, Codable, Identifiable {

    var id: UUID
    var title: String
    var description: String
    var priority: String
    var completed: Bool
    var dueDateAndTime: String


}
