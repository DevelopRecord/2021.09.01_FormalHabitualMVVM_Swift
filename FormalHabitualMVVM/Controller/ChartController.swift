//
//  ChartController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//
// 다양한 습관 리스트들을 만들어 놓고(테이블뷰나 컬렉션뷰) 검색하는 방향으로 가면 어떨까

import UIKit

class ChartController: UIViewController {
    
    // MARK: Properties
    
    private lazy var viewTest: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "1. 루틴을 열심히 해야합니다"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "시작이 반이다 라는 말 몰라요?"
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helper
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Tips"
        
        view.addSubview(viewTest)
        viewTest.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        viewTest.setDimensions(height: 200, width: view.frame.width - 50)
        
        viewTest.addSubview(titleLabel)
        titleLabel.anchor(top: viewTest.safeAreaLayoutGuide.topAnchor, left: viewTest.leftAnchor,  paddingTop: 20, paddingLeft: 15)
        
        viewTest.addSubview(contentLabel)
        contentLabel.anchor(top: titleLabel.bottomAnchor, left: viewTest.leftAnchor, paddingTop: 20, paddingLeft: 15)
    }
}
