//
//  StickerEmojiCell.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/4.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit

class StickerEmojiCell: UICollectionViewCell {
    
    static var identifier = "StickerEmojiCell"
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        setupAppearance()
        contentView.addSubview(textLabel)
        setupLayout()
    }
    
    private func setupAppearance() {
        contentView.backgroundColor = .white
    }
    
    private func setupLayout() {

        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    
    func configure(_ sticker: Sticker) {
        textLabel.text = sticker.source
    }
    
}
