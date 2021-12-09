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
    
    var viewModel: HabitualViewModel? {
        didSet{ configure() }
    }
    
    lazy var listBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray4
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.tag = 10
        button.addTarget(self, action: #selector(didTapRoutineButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(listBtn)
        listBtn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(50)
            make.centerX.equalTo(contentView)
            make.width.equalTo(frame.width - 40)
            make.height.equalTo(75)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func didTapRoutineButton() {
        print("DEBUG: Did tap RoutineButton..")
    }
    
    // MARK: Helpers
    
    func configure() {
        guard let viewModel = viewModel else { return }
        listBtn.setTitle("\(viewModel.title)\n\(viewModel.selectedTime)", for: .normal)
    }
}
