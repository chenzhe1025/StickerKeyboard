//
//  Sticker.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/6.
//  Copyright © 2020 7. All rights reserved.
//

import Foundation
import UIKit

protocol Sticker: Codable {
    var source: String { get }
    var cellSize: CGSize { get }
}


