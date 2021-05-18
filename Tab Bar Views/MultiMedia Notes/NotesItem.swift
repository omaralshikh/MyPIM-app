//
//  NotesItem.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct NotesItem: View {
    
    let note: Notes
    
    var body: some View {
        HStack {
            // This public function is given in UtilityFunctions.swift
            getImageFromDocumentDirectory(filename: note.photoFullFilename.components(separatedBy: ".")[0], fileExtension: note.photoFullFilename.components(separatedBy: ".")[1], defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
           
            VStack(alignment: .leading) {
                Text(note.title)
                Text(note.locationName)
                Text(note.dateTime)
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
           
        }   // End of HStack
    }
 }

struct NotesItem_Previews: PreviewProvider {
    static var previews: some View {
        NotesItem(note: NotesStructList[0])
    }
}
