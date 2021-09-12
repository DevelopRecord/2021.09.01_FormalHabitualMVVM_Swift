//
//  ProfileSettingCell.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/12.
//

import UIKit

class ProfileSettingCell: UITableViewCell {
    
    // MARK: Properties
    
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃"
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(menuLabel)
//        menuLabel.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

