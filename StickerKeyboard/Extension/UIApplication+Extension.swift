//
//  UIApplication+Extension.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/4.
//  Copyright © 2020 7. All rights reserved.
//

import Foundation
import UIKit


extension UIApplication {
    
    static var safeAreaInsets: UIEdgeInsets {
        return UIApplication.shared.windows[0].safeAreaInsets
    }
    
    static var safeAreaLayoutGuide: UILayoutGuide {
        return UIApplication.shared.windows[0].safeAreaLayoutGuide
    }
}
