//
//  StickerKeyboard.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/2.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit

protocol StickerKeyboardDelegate: NSObjectProtocol {
    func keyboard(input image: Sticker)
    func keyboardSendMessage()
}

class StickerKeyboard: UIView {
    
    /// TextInput is TextField or TextView
    weak var textInput: UITextInput?
    
    weak var delegate: StickerKeyboardDelegate?
    
    private var deleteBackwardTimer: Timer?
    
    private var stickers: [Sticker] {
        switch accessoryIndex {
        case 0:
            return emojis
        default:
            return images
        }
    }
    
    /// TODO： debug code
    private lazy var emojis: [Sticker] = {
        let emoji = StickerEmoji(unicode: "\u{1F602}")
        return Array.init(repeating: emoji, count: 100)
    }()
    
    private lazy var images: [Sticker] = {
        let image = StickerImage(url: "https://c-ssl.duitang.com/uploads/item/201701/20/20170120142750_2VYNQ.thumb.700_0.gif")
        return Array.init(repeating: image, count: 80)
    }()
    
    private var accessoryIndex: Int = 0 {
        didSet {
            guard oldValue != accessoryIndex else { return }
            actionsView.isHidden = accessoryIndex != 0
            collectionView.reloadData()
        }
    }
    
    // TODO: custom flowLayout
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionHeadersPinToVisibleBounds = true
        return flowLayout
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        view.isPagingEnabled = false
        view.scrollsToTop = false
        view.delegate = self
        view.dataSource = self
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: UIApplication.safeAreaInsets.bottom, right: 0)
        view.register(StickerEmojiCell.self, forCellWithReuseIdentifier: StickerEmojiCell.identifier)
        view.register(StickerImageCell.self, forCellWithReuseIdentifier: StickerImageCell.identifier)
        view.register(StickerKeyboardAccessoryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StickerKeyboardAccessoryView.identifier)
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        
        return view
    }()
    
    private lazy var actionsView: StickerKeyboardActionsView = {
        let view = StickerKeyboardActionsView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.deleteButton.addTarget(self, action: #selector(didTouchDownDeleteButton(_:)), for: .touchDown)
        view.deleteButton.addTarget(self, action: #selector(didTouchUpInsideDeleteButton(_:)), for: .touchUpInside)
        view.deleteButton.addTarget(self, action: #selector(didTouchUpOutsideDeleteButton(_:)), for: .touchUpOutside)
        view.sendButton.addTarget(self, action: #selector(send(_:)), for: .touchUpInside)
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
        
        addSubview(collectionView)
        addSubview(actionsView)
        
        setupLayout()
    }
    
    private func setupAppearance() {
        backgroundColor = .white
    }
    
    private func setupLayout() {
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        actionsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        actionsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(20 + UIApplication.safeAreaInsets.bottom)).isActive = true
    }
}

// MARK: - Delete button action

extension StickerKeyboard {
    
    @objc
    private func didTouchDownDeleteButton(_ sender: UIButton) {
        deleteBackwardTimer?.invalidate()
        deleteBackwardTimer = .none
        
        deleteBackwardTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(deleteBackward), userInfo: .none, repeats: true)
    }
    
    @objc
    private func didTouchUpInsideDeleteButton(_ sender: UIButton) {
    
        deleteBackwardTimer?.invalidate()
        deleteBackwardTimer = .none
        
        deleteBackward()
    }
    
    @objc
    private func didTouchUpOutsideDeleteButton(_ sender: UIButton) {
        deleteBackwardTimer?.invalidate()
        deleteBackwardTimer = .none
    }
    
    @objc
    private func deleteBackward() {
        if
            let textInput = textInput,
            !textInput.hasText {
            actionsView.isEnabled = false
            actionsView.deleteButton.sendActions(for: .touchUpOutside)
        } else {
            UIDevice.current.playInputClick()
            textInput?.deleteBackward()
        }
    }
}

extension StickerKeyboard {
    @objc
    private func send(_ sender: UIButton) {
        delegate?.keyboardSendMessage()
    }
      
}

extension StickerKeyboard: UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool {
        return true
    }
}

extension StickerKeyboard: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch accessoryIndex {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerEmojiCell.identifier, for: indexPath) as! StickerEmojiCell
            cell.configure(stickers[indexPath.item])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerImageCell.identifier, for: indexPath) as! StickerImageCell
            cell.configure(stickers[indexPath.item])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StickerKeyboardAccessoryView.identifier, for: indexPath) as! StickerKeyboardAccessoryView
        header.accessoryIndex = accessoryIndex
        header.delegate = self
        return header
    }
    
}

extension StickerKeyboard: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sticker = stickers[indexPath.item]
        return sticker.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
}

extension StickerKeyboard: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sticker = stickers[indexPath.item]
        if sticker is StickerEmoji {
            UIDevice.current.playInputClick()
            textInput?.insertText(sticker.source)
            actionsView.isEnabled = true
        } else {
            delegate?.keyboard(input: sticker)
        }
    }
}


extension StickerKeyboard: StickerKeyboardAccessoryViewDelegate {
    func accessoryView(_ accessoryView: StickerKeyboardAccessoryView, didSelctedItemAt indexPath: IndexPath) {
        accessoryIndex = indexPath.item
    }
}

extension StickerKeyboard: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            collectionView.setContentOffset(.zero, animated: false)
        }
    }
}

