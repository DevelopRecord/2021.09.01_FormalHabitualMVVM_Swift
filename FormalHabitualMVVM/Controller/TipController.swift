//
//  TipController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//
// 다양한 습관 리스트들을 만들어 놓고(테이블뷰나 컬렉션뷰) 검색하는 방향으로 가면 어떨까

import UIKit

class TipController: UIViewController {
    
    // MARK: Properties
    
    private let tipViewOne: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "1. 루틴을 지켜야 하는 이유"
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "루틴은 자신의 에너지와 신체 리듬을 관리해주는 면에서 좋죠.\n우리의 하루는 생각보다 반복적인 하루를 지내고 있습니다.\n이 앱을 통해서 쉽게 습관을 만들고 기억해 보세요."
        label.numberOfLines = 4
        return label
    }()
    
    private let tipView_2: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel_2: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "2. 가벼운 습관부터"
        return label
    }()
    
    private let contentLabel_2: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "처음부터 복잡하고 너무 거창한 목표는 좋지 않아요.\n쉽게 지치고 포기하게 되어 버리죠.\n처음에는 하고 싶었던 습관들 중 세개 정도만 설정하고 일주일에 하나씩 점차 늘려가는건 어때요?"
        label.numberOfLines = 4
        return label
    }()
    
    private let tipView_3: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel_3: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "3. 적용해볼만한 간단한 루틴들"
        return label
    }()
    
    private let contentLabel_3: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "일상에 쉽게 적용할 만한 간단한 루틴들은 많이 있습니다.\n아침에 일어나서 물마시기부터 해서 이불개기, 아침밥 먹기 등등요.\n간단하지만 평소에 잘 지키지 못했던 습관부터 실행해봐요."
        label.numberOfLines = 4
        return label
    }()
    
    private let tipView_4: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel_4: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "4. 숙면을 취하는 방법"
        return label
    }()
    
    private let contentLabel_4: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "습관을 만들고 그 루틴을 실행하려면 전날 숙면부터 취해야 하죠.\n우선 정해진 시간에 잠에 들고 일어나야 합니다.그러려면 다음을 따라해 보세요.\n낮에 충분한 햇빛 쬐기, 운동, 반신욕 및 족욕, 커피나 \n초콜릿 등과 같은 카페인 식품 피하기."
        label.numberOfLines = 6
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
        navigationItem.title = "팁"
        
        // MARK: Tip_1
        
        view.addSubview(tipViewOne)
        tipViewOne.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        tipViewOne.setDimensions(height: 140, width: view.frame.width - 50)
        
        tipViewOne.addSubview(titleLabel)
        titleLabel.anchor(top: tipViewOne.safeAreaLayoutGuide.topAnchor, left: tipViewOne.leftAnchor,  paddingTop: 20, paddingLeft: 15)
        
        tipViewOne.addSubview(contentLabel)
        contentLabel.anchor(top: titleLabel.bottomAnchor, left: tipViewOne.leftAnchor, right: tipViewOne.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
        
        // MARK: Tip_2
        
        view.addSubview(tipView_2)
        tipView_2.anchor(top: tipViewOne.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        tipView_2.setDimensions(height: 140, width: view.frame.width - 50)
        
        tipView_2.addSubview(titleLabel_2)
        titleLabel_2.anchor(top: tipView_2.safeAreaLayoutGuide.topAnchor, left: tipView_2.leftAnchor, paddingTop: 20, paddingLeft: 15)
        
        tipView_2.addSubview(contentLabel_2)
        contentLabel_2.anchor(top: titleLabel_2.bottomAnchor, left: tipView_2.leftAnchor, right: tipView_2.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
        
        // MARK: Tip_3
        
        view.addSubview(tipView_3)
        tipView_3.anchor(top: tipView_2.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        tipView_3.setDimensions(height: 140, width: view.frame.width - 50)
        
        tipView_3.addSubview(titleLabel_3)
        titleLabel_3.anchor(top: tipView_3.safeAreaLayoutGuide.topAnchor, left: tipView_3.leftAnchor, paddingTop: 20, paddingLeft: 15)
        
        tipView_3.addSubview(contentLabel_3)
        contentLabel_3.anchor(top: titleLabel_3.bottomAnchor, left: tipView_3.leftAnchor, right: tipView_3.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
        
        // MARK: Tip_4
        
        view.addSubview(tipView_4)
        tipView_4.anchor(top: tipView_3.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        tipView_4.setDimensions(height: 180, width: view.frame.width - 50)
        
        tipView_4.addSubview(titleLabel_4)
        titleLabel_4.anchor(top: tipView_4.safeAreaLayoutGuide.topAnchor, left: tipView_4.leftAnchor, paddingTop: 20, paddingLeft: 15)
        
        tipView_4.addSubview(contentLabel_4)
        contentLabel_4.anchor(top: titleLabel_4.bottomAnchor, left: tipView_4.leftAnchor, right: tipView_4.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
    }
}
