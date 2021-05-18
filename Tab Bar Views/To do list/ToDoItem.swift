//
//  ToDoItem.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct ToDoItem: View {
    let task: ListStruct
    
    @State private var selectedIndex = 0
    let bar = ["Title", "Due Date", "Priority"]
    
    var body: some View {
   
 
        HStack {
            if (task.completed == true) {
                Image(systemName: "checkmark.square")
                    .imageScale(.large).foregroundColor(.blue)

            }
            else {
                Image(systemName: "square")
                    .imageScale(.large).foregroundColor(.blue)

            }

            VStack(alignment: .leading) {

                if (task.priority == "High") {
                    Text(task.title).foregroundColor(.red)
                    Text(task.dueDateAndTime).foregroundColor(.red)


                }
                if (task.priority == "Low") {
                    Text(task.title).foregroundColor(.black)
                    Text(task.dueDateAndTime).foregroundColor(.black)


                }
                if (task.priority == "Normal") {
                    Text(task.title).foregroundColor(.green)
                    Text(task.dueDateAndTime).foregroundColor(.green)


                }
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))

        }
    }
}

struct ToDoItem_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItem(task: ListStructList[0])
    }
}
