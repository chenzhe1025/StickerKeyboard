//
//  StickerKeyboardAccessoryView.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/6.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit

protocol StickerKeyboardAccessoryViewDelegate: NSObjectProtocol {
    func accessoryView(_ accessoryView: StickerKeyboardAccessoryView, didSelctedItemAt indexPath: IndexPath)
}

class StickerKeyboardAccessoryView: UICollectionReusableView {
    
    static var identifier = "StickerKeyboardAccessoryView"
    
    weak var delegate: StickerKeyboardAccessoryViewDelegate?
    
    var accessoryIndex: Int = 0 {
        didSet {
            collectionView.layoutIfNeeded()
            let cell = collectionView.cellForItem(at: IndexPath(item: accessoryIndex, section: 0))
            cell?.isSelected = true
        }
    }
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .gray
        view.isPagingEnabled = false
        view.scrollsToTop = false
        view.delegate = self
        view.dataSource = self
        view.register(StickerKeyboardAccessoryCell.self, forCellWithReuseIdentifier: StickerKeyboardAccessoryCell.identifier)
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
        
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
        
        setupLayout()
    }
    
    private func setupAppearance() {
        backgroundColor = .gray
    }
    
    private func setupLayout() {
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}


extension StickerKeyboardAccessoryView: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerKeyboardAccessoryCell.identifier, for: indexPath)
        return cell
    }
}

extension StickerKeyboardAccessoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        return CGSize(width: screenWidth / 10, height: screenWidth / 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
    
}

extension StickerKeyboardAccessoryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.accessoryView(self, didSelctedItemAt: indexPath)
        
        if  accessoryIndex != indexPath.item,
            let oldSelctedCell = collectionView.cellForItem(at: IndexPath(item: accessoryIndex, section: 0)) {
            oldSelctedCell.isSelected = false
        }
    }
}
