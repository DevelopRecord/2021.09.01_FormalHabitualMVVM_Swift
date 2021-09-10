//
//  ProfileCell.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/08.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let myRoutineButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My Routine 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(myRoutineButton)
        myRoutineButton.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
