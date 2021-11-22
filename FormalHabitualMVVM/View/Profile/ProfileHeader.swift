//
//  ProfileHeader.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/08.
//

import UIKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    
    // MARK: Properties
    
    var viewModel: ProfileHeaderViewModel? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, paddingTop: 35)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12, paddingBottom: 35)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let topDivider = UIView()
        topDivider.backgroundColor = .systemGray5

        addSubview(topDivider)

        topDivider.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 25, height: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
    
}



/*
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

        let bottomDivider = UIView()
        bottomDivider.backgroundColor = .lightGray
        
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        buttonStack.distribution = .fillEqually
        
        addSubview(buttonStack)

        addSubview(bottomDivider)
        
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        bottomDivider.anchor(top: buttonStack.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
*/
