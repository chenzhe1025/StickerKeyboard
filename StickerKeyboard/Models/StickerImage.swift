//
//  StickerImage.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/6.
//  Copyright © 2020 7. All rights reserved.
//

import Foundation
import UIKit

struct StickerImage: Codable, Sticker {
    
    var source: String {
        return url
    }
    
    var cellSize: CGSize  {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        return CGSize(width: screenWidth/5, height: screenWidth/5)
    }
    
    let url: String
    // TODO：codingkeys
    init(url: String) {
        self.url = url
    }
    
}
