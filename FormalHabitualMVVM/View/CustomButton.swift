//
//  CustomButton.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/03.
//

import UIKit

class CustomButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 45, width: 45)
        
        titleLabel?.font = .systemFont(ofSize: 11)
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        backgroundColor = .systemGray5
        setTitleColor(.black, for: .normal)
        frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        setHeight(45)
        setWidth(45)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomActionSheetButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: frame.width - 50)
        
        backgroundColor = .systemGray5
        setTitleColor(.black, for: .normal)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        setHeight(50)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
