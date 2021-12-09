//
//  InputTextView2.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/11/28.
//

import UIKit

class InputTextView2: UITextView {
    
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }
    
    // MARK: Properties
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeholderLabel.snp.makeConstraints { make in
                    make.leading.equalTo(self.snp.leading).offset(8)
                    make.trailing.equalTo(self.snp.trailing)
                    make.centerY.equalTo(self)
                }
            } else {
                placeholderLabel.snp.makeConstraints { make in
                    make.top.equalTo(self.snp.top).offset(6)
                    make.left.equalTo(self.snp.left).offset(8)
                }
            }
        }
    }
    
    // MARK: Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func handleTextDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

