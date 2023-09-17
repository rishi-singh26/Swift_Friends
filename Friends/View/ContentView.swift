//
//  ContentView.swift
//  Friends
//
//  Created by Rishi Singh on 17/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var usersData = Users()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(usersData.users) { user in
                    NavigationLink {
                        FriendDetailView(usersData: usersData, userData: user)
                    } label: {
                        HStack {
                            Circle()
                                .fill(user.isActive ? .green : .red)
                                .frame(width: 10, height: 10)
                            Text(user.name)
                        }
                    }
                }
                .onDelete(perform: deleteIndex)
            }
            .task{
                await usersData.loadUsers()
            }
            .navigationTitle("Friends")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Text("\(usersData.users.count) Friends")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func deleteIndex(indexSet: IndexSet) {
        withAnimation {
            usersData.users.remove(atOffsets: indexSet)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
