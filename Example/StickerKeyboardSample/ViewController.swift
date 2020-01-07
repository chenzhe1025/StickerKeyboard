//
//  ViewController.swift
//  StickerKeyboard
//
//  Created by 7 on 2020/1/2.
//  Copyright © 2020 7. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var textFiledBar: TextFiledBar = {
        let bar = TextFiledBar()
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTapGestureRecognizer()
    }
    
    
    private func setupUI() {
        
        view.addSubview(textFiledBar)
        textFiledBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textFiledBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textFiledBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    private func setupTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func tapGestureRecognizerAction(_ sender: UIGestureRecognizer) {
        textFiledBar.resign()
    }


}

