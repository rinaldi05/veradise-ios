//
//  TabBar.swift
//  Veradise
//
//  Created by Rinaldi LNU on 09/08/21.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 2
    
    var body: some View {
        TabView(selection: $selectedTab,
            content:  {
                CardView().tabItem {
                    Image(systemName: selectedTab == 1 ? "creditcard.fill" : "creditcard")
                    Text("Card")
                }.tag(1)
                ProfileView().tabItem {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                    Text("Profile")
                }.tag(2)
            }
        )
        .accentColor(VeradiseConfiguration.brandColor)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
