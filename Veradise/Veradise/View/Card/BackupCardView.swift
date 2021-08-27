//
//  BackupCardView.swift
//  Veradise
//
//  Created by Rinaldi LNU on 14/08/21.
//

import SwiftUI
//
//struct CardView: View {
//    var body: some View {
//        GeometryReader(content: { geometry in
//            let topEdge = geometry.safeAreaInsets.top
//            NavBarCard(navTitle: "My Card", topEdge: topEdge)
//                .ignoresSafeArea()
//        })
//    }
//}
//
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
//
//struct NavBarCard: View {
//    @State var navTitle: String
//    @State var offset: CGFloat = 0
//    var topEdge: CGFloat
//    let maxHeight = UIScreen.screenHeight/4.3
//    
//    @State var setIndex: Int = 0
//    @State var cardData: [CardModel] = [
//        CardModel(id: 0, offset: 0, name: "Kartu Tanda Penduduk"),
//        CardModel(id: 1, offset: 0, name: "Sertifikat Vaksin"),
////        CardModel(id: 2, offset: 0, name: "Kartu Keluarga"),
//    ]
//    @State var scrolled: Int = 0
//    
//    func getOpacityNavBarSmallTitle() -> CGFloat {
//        let progress = -offset / UIScreen.radiusSize
//        return progress < 1 ? progress : 1
//    }
//    
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack(spacing: 15) {
//                GeometryReader(content: { geometry in
//                    VStack(alignment: .leading, spacing: 15) {
//                        NavBarTitle(navTitle: $navTitle, offset: $offset, topEdge: topEdge)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .frame(height: getHeaderHeight(), alignment: .bottom)
//                    .background(
//                        CustomCorner(corners: [.bottomRight], radius: getCornerRadius()).fill(
//                            LinearGradient(
//                                gradient: .init(colors: [
//                                    Color("TopBackground-1"),
//                                    Color("TopBackground-2")
//                                ]),
//                                startPoint: .init(x: 0, y: 0.5),
//                                endPoint: .init(x: 1, y: 1)
//                            )
//                        )
//                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
//                    )
//                    .overlay(
//                        HStack(spacing: 15) {
//                            Button(action: {
//                                //Action
//                            }, label: {
//                                Image(systemName: "chevron.backward")
//                                    .imageScale(.large)
//                                    .accentColor(.primary)
//                            })
//                            Spacer()
//                            Text(navTitle)
//                                .font(.system(size: 18, design: .rounded))
//                                .bold()
//                                .opacity(Double(getOpacityNavBarSmallTitle()))
//                            Spacer()
//                            Button(action: {
//                                //Action
//                            }, label: {
//                                Image(systemName: "plus")
//                                    .imageScale(.large)
//                                    .accentColor(.primary)
//                            })
//                        }
//                        .padding(.horizontal)
//                        .frame(height: UIScreen.headerSize)
//                        .padding(.top, topEdge)
//                        , alignment: .top
//                    )
//                    
//                })
//                .frame(height: maxHeight)
//                .offset(y: -offset)
//            }
//            .zIndex(1)
//            .modifier(OffsetModifier(offset: $offset))
//            
//            VStack(spacing: 5) {
//                HStack {
//                    Text("Card List")
//                        .font(.system(.caption, design: .rounded))
//                    Spacer()
//                }
//                .padding(.horizontal)
//                
//                ZStack {
//                    ForEach(cardData.reversed()) { card in
//                        HStack {
////                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(Color.purple)
//                                Text("Card - \(card.id)")
//                                
//                            }
//                            .frame(width: calculateWidth(), height: UIScreen.sizeCardHeight - CGFloat(card.id - scrolled) * 60)
//                            .offset(x: card.id - scrolled <= 2 ? CGFloat(card.id - scrolled) * 30 : 60)
//                            Spacer(minLength: 0)
//                        }
//                        .contentShape(Rectangle())
//                        .offset(x: CGFloat(card.offset))
//                        .gesture(
//                            DragGesture()
//                                .onChanged({ (value) in
//                                    withAnimation {
//                                        if value.translation.width < 0 && card.id != cardData.last?.id {
//                                            cardData[card.id].offset = value.translation.width
//                                        } else {
//                                            if card.id > 0 {
//                                                cardData[card.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
//                                            }
//                                        }
//                                    }
//                                })
//                                .onEnded({ (value) in
//                                    withAnimation {
//                                        if value.translation.width < 0 && card.id != cardData.last?.id {
//                                            print(cardData, "DATA CARD")
//                                            if -value.translation.width > 180 && card.id != cardData.last?.id {
//                                                cardData[card.id].offset = -(calculateWidth() + 60)
//                                                scrolled += 1
//                                            } else {
//                                                cardData[card.id].offset = 0
//                                            }
//                                        } else {
//                                            if card.id > 0 {
//                                                if value.translation.width > 180 {
//                                                    cardData[card.id - 1].offset = 0
//                                                    scrolled -= 1
//                                                } else {
//                                                    cardData[card.id - 1].offset = -(calculateWidth() + 60)
//                                                }
//                                            }
//                                        }
//                                    }
//                                })
//                        )
//                    }
//                }
//                .frame(height: UIScreen.sizeCardHeight)
//                .padding(.horizontal)
//            }
//            .zIndex(0)
//        }
//        .coordinateSpace(name: "scroll")
//    }
//    
//    func calculateWidth() -> CGFloat {
//        let screen = UIScreen.screenWidth - 30
//        let width = screen - (2 * 30)
//        return width
//    }
//    
//    func getHeaderHeight() -> CGFloat {
//        let topHeight = maxHeight + offset
//        return topHeight > (UIScreen.headerSize + topEdge) ? topHeight : (UIScreen.headerSize + topEdge)
//    }
//    
//    func getCornerRadius() -> CGFloat {
//        let progress = -offset / (maxHeight - (UIScreen.headerSize + topEdge))
//        let value = 1 - progress
//        let radius = value * UIScreen.radiusSize
//        return offset < 0 ? radius : UIScreen.radiusSize
//    }
//}
//
//struct CardModel: Identifiable {
//    var id: Int
//    var offset: CGFloat
//    var name: String
//}
