//
//  ChartController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class ChartController: UIViewController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // 다양한 습관 리스트들을 만들어 놓고(테이블뷰나 컬렉션뷰) 검색하는 방향으로 가면 어떨까
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .systemBlue
        
        navigationController?.navigationBar.isHidden = true
    }
}
