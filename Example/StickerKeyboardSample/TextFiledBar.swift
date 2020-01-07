//
//  TextFiledBar.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/2.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit

class TextFiledBar: UIView {


    lazy var textFiled: UITextField = {
        let textFiled = UITextField()
        textFiled.backgroundColor = .white
        textFiled.textColor = .black
        textFiled.font = UIFont.systemFont(ofSize: 16)
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        return textFiled
    }()
    
    lazy var stickerToggleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "toggle_emoji"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "toggle_keyboard"), for: .selected)
        button.addTarget(self, action: #selector(stickerToggle(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var stickerKeyboard: StickerKeyboard = {
        let view = StickerKeyboard()
        view.delegate = self
        view.textInput = self.textFiled
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return view
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
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(textFiled)
        addSubview(stickerToggleButton)
        setupLayout()
        setupObservers()
    }
    
    private func setupAppearance() {
        backgroundColor = .lightGray
    }
    
    private func setupLayout() {
        
        textFiled.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textFiled.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44).isActive = true
        textFiled.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        textFiled.bottomAnchor.constraint(equalTo: bottomAnchor,  constant: -UIApplication.safeAreaInsets.bottom).isActive = true
        textFiled.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        
        stickerToggleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        stickerToggleButton.centerYAnchor.constraint(equalTo: textFiled.centerYAnchor).isActive = true
        stickerToggleButton.widthAnchor.constraint(equalTo: stickerToggleButton.heightAnchor).isActive = true
        
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc
    private func stickerToggle(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        switch sender.isSelected {
        case true:
            textFiled.inputView = stickerKeyboard
            textFiled.reloadInputViews()
            textFiled.becomeFirstResponder()
        case false:
            textFiled.inputView = .none
            stickerKeyboard.removeFromSuperview()
            textFiled.reloadInputViews()
            
            // TODO: API error: _UIKBCompatInputView returned 0 width, assuming UIViewNoIntrinsicMetric
        }
    }
    
    func resign() {
        textFiled.resignFirstResponder()
        stickerToggleButton.isSelected = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

extension TextFiledBar: StickerKeyboardDelegate {
    func keyboardSendMessage() {
        // send normal message
    }
    
    func keyboard(input image: Sticker) {
        // send image message
    }
  
}

extension TextFiledBar {
    @objc
    private func keyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
    
        if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight: CGFloat = UIScreen.main.bounds.height - keyboardFrame.origin.y.rounded(.up)
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duration ?? 0.25) {
                self.transform = CGAffineTransform.init(translationX: 0, y: keyboardHeight > 0 ? -keyboardHeight : 0)
                
            }
        }
    }
}
