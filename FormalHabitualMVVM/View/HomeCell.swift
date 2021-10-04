//
//  HomeCell.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/28.
//

import UIKit
import Firebase

class HomeCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let listBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray3
        button.setTitle("제목입니다\n시간입니다", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.addTarget(self, action: #selector(handleListButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Actions
    
    @objc func handleListButton() {
        print("DEBUG: Handled list button..")
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(listBtn)
        listBtn.anchor(top: topAnchor, paddingTop: 50, paddingLeft: 20, paddingRight: 20)
        listBtn.centerX(inView: contentView)
        listBtn.setDimensions(height: 75, width: frame.width - 40)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
