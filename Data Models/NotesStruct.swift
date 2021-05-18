//
//  NotesStruct.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct Notes: Hashable, Codable, Identifiable {
    
    var id: UUID
    var title: String
    var textualNote: String
    var photoFullFilename: String
    var audioFullFilename: String
    var speechToTextNote: String
    var locationName: String
    var dateTime: String
    var latitude: Double
    var longitude: Double
    
}
