//
//  Utility.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import UIKit

class Utility {
    
    // Screen width.
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    // Screen height.
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

public extension UIDevice {

    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }

    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }

    class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }

    class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
}
