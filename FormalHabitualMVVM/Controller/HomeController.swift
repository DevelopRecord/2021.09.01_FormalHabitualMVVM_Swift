//
//  HomeController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    let timeSelector : Selector = #selector(HomeController.updateTime)
    let interval = 1.0
    var count = 0
    
    // MARK: Properties
    private let currentTimeLabel: UILabel = {
        let timeLabel = UILabel()
        return timeLabel
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.addTarget(self, action: #selector(addButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let listBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGray3
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.systemGray5.cgColor
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "로그아웃",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogout))
        
        configureColors()
        
        view.addSubview(currentTimeLabel)
        currentTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        currentTimeLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(listBtn)
        listBtn.translatesAutoresizingMaskIntoConstraints = false
        listBtn.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 30).isActive = true
        listBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        listBtn.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        listBtn.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    // MARK: Actions
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    @objc func addButtonTapped() {
        let uvc = AddHabitualController()
        uvc.modalPresentationStyle = .fullScreen
        self.present(uvc, animated: true)
    }
    
    @objc func updateTime() {
        let date = NSDate() // 현재 시간을 가져옴
        let formatter = DateFormatter() // DateFormatter라는 클래스의 상수 formatter를 선언
        formatter.dateFormat = "M.dd (E) h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.locale = Locale(identifier: "ko_kr")
        currentTimeLabel.text = formatter.string(from: date as Date)
    }
    
    // MARK: Configures
    func configureColors() {
        if self.traitCollection.userInterfaceStyle == .dark { //유저 인터페이스가 다크 테마일 때
            addButton.backgroundColor = .darkGray
            addButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else { //일반 라이트 모드일 때
            addButton.setTitleColor(UIColor.systemGray, for: UIControl.State.normal)
            addButton.backgroundColor = .white
        }
    }
}
