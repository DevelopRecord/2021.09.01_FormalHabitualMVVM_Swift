//
//  File.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class TableCell: UITableViewCell {
    
    // MARK: Properties
    
    var item: String? { // 값을 전달을 받으면 label에 전달받은 값을 넣는 작업을 수행합니다
        didSet {
            self.label.text = item
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    
    func configureUI() {
        backgroundColor = .white
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
