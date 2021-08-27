//
//  NavBar.swift
//  Veradise
//
//  Created by Rinaldi LNU on 09/08/21.
//

import SwiftUI

struct NavBarTitle: View {
    @Binding var navTitle: String
    @Binding var offset: CGFloat
    var topEdge : CGFloat
    
    var body: some View {
        HStack {
            Text(navTitle)
                .font(.system(size: 36, design: .rounded))
                .bold()
            Spacer()
        }
        .padding()
        .padding(.bottom)
        .opacity(Double(getOpacity()))
    }
    
    func getOpacity() -> CGFloat {
        let progress = -offset / 50
        let opacity = 1 - progress
        return offset < 0 ? opacity : 1
    }
}

struct NavBar: View {
    @State var navTitle: String
    @State var offset: CGFloat = 0
    var topEdge: CGFloat
    let maxHeight = UIScreen.screenHeight/4.3
    var contentVStack: some View = Text("")
    
    func getOpacityNavBarSmallTitle() -> CGFloat {
        let progress = -offset / 50
        return progress < 1 ? progress : 1
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                GeometryReader(content: { geometry in
                    VStack(alignment: .leading, spacing: 15) {
                        NavBarTitle(navTitle: $navTitle, offset: $offset, topEdge: topEdge)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: getHeaderHeight(), alignment: .bottom)
                    .background(
                        CustomCorner(corners: [.bottomRight], radius: getCornerRadius()).fill(
                            LinearGradient(
                                gradient: .init(colors: [Color("TopBackground-1"), Color("TopBackground-2")]),
                                startPoint: .init(x: 0, y: 0.5),
                                endPoint: .init(x: 1, y: 1)
                            )
                        )
                    ).overlay(
                        HStack(spacing: 15) {
                            Button(action: {
                                //Action
                            }, label: {
                                Image(systemName: "chevron.backward")
                                    .imageScale(.large)
                                    .accentColor(.primary)
                            })
                            Spacer()
                            Text(navTitle)
                                .font(.system(size: 18, design: .rounded))
                                .bold()
                                .opacity(Double(getOpacityNavBarSmallTitle()))
                            Spacer()
                            Button(action: {
                                //Action
                            }, label: {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                                    .accentColor(.primary)
                            })
                        }
                        .padding(.horizontal)
                        .frame(height: 80)
                        .padding(.top, topEdge)
                        , alignment: .top
                    )
                    
                })
                .frame(height: maxHeight)
                .offset(y: -offset)
            }
            .zIndex(1)
            .modifier(OffsetModifier(offset: $offset))
            
            VStack(spacing: 15) {
                HStack {
                    Text("TEST")
                }
            }
            .zIndex(0)
        }
        .coordinateSpace(name: "scroll")
    }
    
    func getHeaderHeight() -> CGFloat {
        let topHeight = maxHeight + offset
        return topHeight > (80 + topEdge) ? topHeight : (80 + topEdge)
    }
    
    func getCornerRadius() -> CGFloat {
        let progress = -offset / (maxHeight - (80 + topEdge))
        let value = 1 - progress
        let radius = value * 50
        return offset < 0 ? radius : 50
    }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { geometry -> Color in
                let minY = geometry.frame(in: .named("scroll")).minY
                DispatchQueue.main.async {
                    self.offset = minY
                }
                return Color(.clear)
            }, alignment: .top
        )
    }
}
