//
//  FriendDetailView.swift
//  Friends
//
//  Created by Rishi Singh on 17/09/23.
//

import SwiftUI

struct FriendDetailView: View {
    @ObservedObject var usersData: Users
    
    let userData: User
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        List {
            Section("Details") {
                UserDataView(data: userData.email, dataKey: "Email")
                UserDataView(data: String(userData.age), dataKey: "Age")
                UserDataView(data: userData.address, dataKey: "Address")
                UserDataView(data: userData.company, dataKey: "Company")
                UserDataView(data: userData.about, dataKey: "About")
                UserDataView(
                    data: String(userData.registered.formatted(date: .abbreviated, time: .omitted)),
                    dataKey: "Registered On"
                )
            }
            
            Section("Friends") {
                ForEach(userData.friends) {friend in
                    Text(friend.name)
                }
            }
        }
        .listStyle(.sidebar)
        .navigationTitle(userData.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Circle()
                    .fill(userData.isActive ? .green : .red)
                    .frame(width: 10, height: 10)
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                Text("\(userData.friends.count) Friends")
                Button {
                    showDeleteAlert = true
                } label: {
                    Label("Delete", systemImage: "trash")
                        .tint(.red)
                        .font(Font.footnote)
                }
            }
        }
        .alert("Alert!", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                usersData.users.removeAll { user in
                    user.id == userData.id
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete \(userData.name)?")
        }
    }
}

struct UserDataView: View {
    let data: String
    let dataKey: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(dataKey)
                .padding(.bottom, 0.3)
                .foregroundColor(.secondary)
            Text(data)
        }
    }
}
