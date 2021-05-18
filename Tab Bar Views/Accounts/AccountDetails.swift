//
//  AccountDetails.swift
//  MyPIM
//
//  Created by Omar on 10/18/20.
//  Copyright © 2020 Omar Alshikh. All rights reserved.
//

import SwiftUI

struct AccountDetails: View {
    let account: Accounts

    var body: some View {
        Form {
            Section(header: Text("Account Title")) {
                Text(account.title)
            }
            
            Section(header: Text("Category")) {
                Image(account.category)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
            }
            
            Section(header: Text("Show Acoount website")) {
                Link(destination: URL(string: account.url)!) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                        Text("show account website")
                    }
                }
                
            }
            Section(header: Text("Account Username")) {
                Text(account.username)
            }
            
            Section(header: Text("Account Password")) {
                Text(account.password)
            }
            
            Section(header: Text("Account Notes")) {
                Text(account.notes)
            }
            
            

        } // form
        }
}

struct AccountDetails_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetails(account: AccountStructList[0])
    }
}
