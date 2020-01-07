//
//  StickerEmoji.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/6.
//  Copyright © 2020 7. All rights reserved.
//

import Foundation
import UIKit

struct StickerEmoji: Codable, Sticker {
   
    var source: String {
        return unicode
    }
    
    var cellSize: CGSize  {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        return CGSize(width: screenWidth/10, height: screenWidth/10)
    }
    
    let unicode: String
    
    init(unicode: String) {
        self.unicode = unicode
    }
    
}
