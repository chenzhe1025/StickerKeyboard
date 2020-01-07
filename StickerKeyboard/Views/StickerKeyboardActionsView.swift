//
//  StickerKeyboardActionsView.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/7.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit


class StickerKeyboardActionsView: UIStackView {
    
    var isEnabled: Bool = false {
        didSet {
            let color: UIColor = isEnabled ? .black : .lightGray
            let image: UIImage = #imageLiteral(resourceName: "delete-emoji").withTintColor(color)
            deleteButton.setImage(image, for: .normal)
            sendButton.setTitleColor(color, for: .normal)
            deleteButton.isEnabled = isEnabled
            sendButton.isEnabled = isEnabled
        }
    }
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        return button
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        button.setTitle("发送", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    private lazy var backgroundLayer: CALayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        isEnabled = false
        axis = .horizontal
        distribution = .fill
        spacing = 6
        addArrangedSubview(deleteButton)
        addArrangedSubview(sendButton)
    }
    
}
