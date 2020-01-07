//
//  StickerKeyboardAccessoryCell.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/6.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit

class StickerKeyboardAccessoryCell: UICollectionViewCell {
    
    static var identifier = "StickerKeyboardAccessoryCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "toggle_emoji")
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override var isSelected: Bool {
        didSet {
            let image = isSelected ? #imageLiteral(resourceName: "toggle_emoji").withTintColor(.yellow) : #imageLiteral(resourceName: "toggle_emoji")
            imageView.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
     
    private func setup() {
        setupAppearance()
        contentView.addSubview(imageView)
        setupLayout()
    }
    
    private func setupAppearance() {
        backgroundColor = .gray
    }
    
    private func setupLayout() {
        
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
