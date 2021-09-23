//
//  SettingCell.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/10.
//

import UIKit

class SettingCell: UITableViewCell {
    
    // MARK: Properties
    
    var item: String? {
        didSet {
            self.settingLabel.text = item
        }
    }
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(settingLabel)
        settingLabel.anchor(left: leftAnchor, paddingLeft: 20)
        settingLabel.centerY(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
