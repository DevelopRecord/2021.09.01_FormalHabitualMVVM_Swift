//
//  ProfileHeader.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/08.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Baek")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jong Won Baek"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Grid", for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("List", for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Bookmark", for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, paddingTop: 16)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let topDivider = UIView()
        topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        topDivider.anchor(top: buttonStack.topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
        bottomDivider.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
}
