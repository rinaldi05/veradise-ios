//
//  CardView.swift
//  Veradise
//
//  Created by Rinaldi LNU on 13/08/21.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        GeometryReader(content: { geometry in
            let topEdge = geometry.safeAreaInsets.top
            NavBarCard(navTitle: "My Card", topEdge: topEdge)
                .ignoresSafeArea()
        })
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

struct NavBarCard: View {
    @State var navTitle: String
    @State var offset: CGFloat = 0
    var topEdge: CGFloat
    let maxHeight = UIScreen.screenHeight/4.3
    
    @State var setIndex: Int = 0
    @State var cardData: [CardModel] = [
        CardModel(id: 0, offset: 0, name: "Kartu Tanda Penduduk", show: false, place: 1),
        CardModel(id: 1, offset: 0, name: "Sertifikat Vaksin", show: false, place: 2),
        CardModel(id: 2, offset: 0, name: "Kartu Keluarga", show: false, place: 3),
    ]
    @State var scrolled: Int = 0
    
    func getOpacityNavBarSmallTitle() -> CGFloat {
        let progress = -offset / UIScreen.radiusSize
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
                                gradient: .init(colors: [
                                    Color("TopBackground-1"),
                                    Color("TopBackground-2")
                                ]),
                                startPoint: .init(x: 0, y: 0.5),
                                endPoint: .init(x: 1, y: 1)
                            )
                        )
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
                    )
                    .overlay(
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
                        .frame(height: UIScreen.headerSize)
                        .padding(.top, topEdge)
                        , alignment: .top
                    )
                    
                })
                .frame(height: maxHeight)
                .offset(y: -offset)
            }
            .zIndex(1)
            .modifier(OffsetModifier(offset: $offset))
            
            VStack {
                Text("")
                GeometryReader { geometry in
                    ScrollView {
                        
                    }
                    ForEach(cardData.reversed()) { card in
                        ZStack {
                            Image("pedulilindungi-background")
                                .resizable()
                                .frame(width: UIScreen.sizeCardPaddingHorizontal)
                                .aspectRatio(contentMode: .fill)
                                .background(Color.white)
                                .clipped()
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                            
                            HStack(alignment: .firstTextBaseline) {
                                VStack(alignment:.leading, spacing: 5) {
                                    Spacer()
                                    Text("PeduliLindungi")
                                        .font(.system(.title2, design: .rounded))
                                        .foregroundColor(Color("pedulilindungi-brand"))
                                    Text("Sertifikat Vaksin Pertama")
                                        .font(.system(.subheadline, design: .rounded))
                                }
                                .padding()
                                .frame(minHeight: UIScreen.sizeCardPaddingHorizontal/2)
                                Spacer()
                            }
                            .frame(width: UIScreen.sizeCardPaddingHorizontal)
                        }
                        .contentShape(Rectangle())
                    }
                    .padding(.horizontal)
                }
                
            }
            .zIndex(0)
        }
        .coordinateSpace(name: "scroll")
    }
    
    func calculateWidth() -> CGFloat {
        let screen = UIScreen.screenWidth - 30
        let width = screen - (2 * 30)
        return width
    }
    
    func getHeaderHeight() -> CGFloat {
        let topHeight = maxHeight + offset
        return topHeight > (UIScreen.headerSize + topEdge) ? topHeight : (UIScreen.headerSize + topEdge)
    }
    
    func getCornerRadius() -> CGFloat {
        let progress = -offset / (maxHeight - (UIScreen.headerSize + topEdge))
        let value = 1 - progress
        let radius = value * UIScreen.radiusSize
        return offset < 0 ? radius : UIScreen.radiusSize
    }
}

struct CardModel: Identifiable {
    var id: Int
    var offset: CGFloat
    var name: String
    var show: Bool
    var place: Int
}
