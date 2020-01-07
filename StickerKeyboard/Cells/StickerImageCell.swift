//
//  StickerImageCell.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/6.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit
import Kingfisher

class StickerImageCell: UICollectionViewCell {
    
    static var identifier = "StickerImageCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        contentView.addSubview(imageView)
        setupLayout()
    }
    
    private func setupAppearance() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func configure(_ sticker: Sticker) {
        imageView.kf.setImage(with: URL(string: sticker.source))
    }
    
}
