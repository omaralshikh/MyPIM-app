//
//  AccountItem.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct AccountItem: View {
    let account: Accounts
    
    var body: some View {
        HStack {
           Image(account.category)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)

            VStack(alignment: .leading) {
                Text(account.title)
               
                Text(account.category + " Account")
                Text(account.username)
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))

        }
    }
}

struct AccountItem_Previews: PreviewProvider {
    static var previews: some View {
        AccountItem(account: AccountStructList[0])
    }
}
