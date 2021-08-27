//
//  Extension.swift
//  Veradise
//
//  Created by Rinaldi LNU on 09/08/21.
//

import Foundation
import SwiftUI

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    static let sizePaddingHorizontal = CGFloat(30)
    static let sizeCardPaddingHorizontal = screenWidth-CGFloat(60)
    static let headerSize = CGFloat(80)
    static let radiusSize = CGFloat(50)
    static let sizeCardHeight = CGFloat(screenHeight/2)
}
