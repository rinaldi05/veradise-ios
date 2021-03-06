//
//  ContentView.swift
//  Watch Extension
//
//  Created by Rinaldi LNU on 16/08/21.
//

import SwiftUI


struct FormatInventory : Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var expiryInt: Int
    var icon: String
}

struct ContentView: View {
    @State var dataInventory : [FormatInventory] = [
        FormatInventory(title: "Paha Ayam", subtitle: "Fridge ・ 1Kg", expiryInt: 3, icon: "🥩"),
        FormatInventory(title: "Sayur", subtitle: "Freezer ・ 10Pcs", expiryInt: 5, icon: "🥦")
    ]
        
    var body: some View {
        NavigationView {
            GeometryReader(content: { geometry in
                List {
                    ForEach(dataInventory, id:\.id) {
                        data in
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 30, height: 30)
                                Text(data.icon).font(.system(.body))
                            }
                            VStack(alignment: .leading) {
                                Text(data.title).font(.system(.body, design: .rounded))
                                Text(data.subtitle).font(.system(.footnote, design: .rounded))
                            }
                        }
                    }
                }
            }).navigationTitle("Expiremind")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
