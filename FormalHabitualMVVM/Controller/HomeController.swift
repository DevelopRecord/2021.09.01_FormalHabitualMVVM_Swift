//
//  HomeController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import Firebase
import SnapKit

private let reusableIdentifier = "Cell"

class HomeController: UICollectionViewController {
    
    // MARK: Properties
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let timeSelector : Selector = #selector(HomeController.updateTime)
    let interval = 1.0
    var count = 0
    
    var habituals = [Habitual]()
    
    private let notExistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "(추가한 습관이 없습니다.)"
        label.textColor = .systemGray4
        return label
    }()
    
    private let currentTimeLabel: UILabel = {
        let timeLabel = UILabel()
        return timeLabel
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_routine"), for: .normal)
        button.tintColor = .lightGray
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchHabituals()
        
        requestNotificationAuthorization()
        sendNotification(seconds: 60)
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector,
                             userInfo: nil, repeats: true)
    }
    
    // MARK: Local Notification
    
    func requestNotificationAuthorization() { // 알림권한 요청 함수(권한 허용여부 팝업)
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("DEBUG: Occured error in requestNotificationAuthorization.. \(error.localizedDescription)")
            }
        }
    }
    
    func sendNotification(seconds: Double) { // 알림을 보내는 함수
        let notificationContent = UNMutableNotificationContent()
        let date = Date()
        let components = DateComponents()
        
        
        notificationContent.title = "오늘의 명언"
        notificationContent.body = "알림 테스트입니다!!!"
        
        
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        dateComponents.hour = 09
        dateComponents.minute = 00
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("DEBUG: Occured error in sendNotification.. \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        fetchHabituals()
    }
    
    // MARK: Actions
    
    @objc func handleRefresh() {
        habituals.removeAll()
        fetchHabituals()
    }
    
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
        let controller = AddHabitualController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @objc func updateTime() {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd (E) h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.locale = Locale(identifier: "ko_kr")
        currentTimeLabel.text = formatter.string(from: date as Date)
    }
    
    @objc func handleSelectOrCancelButton(_ sender: UIBarButtonItem) {
        if self.collectionView.allowsMultipleSelection == false {
            self.collectionView.allowsMultipleSelection = true
            let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.handleSelectOrCancelButton(_:)))
            
            let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleTrashButton(_:)))
            trashButton.tintColor = .red
            
            self.navigationItem.rightBarButtonItems = [cancelButton, trashButton]
        } else {
            self.collectionView.allowsMultipleSelection = false
            
            let selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.handleSelectOrCancelButton(_:)))
            self.navigationItem.rightBarButtonItems = [selectButton]
        }
    }
    
    @objc func handleEditButton() {
        print("DEBUG: 에딧버튼 터치")
    }
    
    @objc func handleTrashButton(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: API
    
    func fetchHabituals() {
        HabitualService.fetchHabituals { habituals in
            self.habituals = habituals
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Helpers
    
    func configureUI() {
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        navigationItem.title = "홈"
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "로그아웃",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "labelColor")
        
        let selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(handleSelectOrCancelButton(_:)))
        navigationItem.rightBarButtonItems = [selectButton]
        selectButton.tintColor = UIColor(named: "labelColor")
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
        
        collectionView.addSubview(currentTimeLabel)
        currentTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
        }
        
        collectionView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.right.equalTo(collectionView.safeAreaLayoutGuide.snp.right).offset(-20)
            make.width.height.equalTo(55)
        }
        
    }
}

// MARK: UICollectionViewDataSource

extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habituals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! HomeCell
        cell.viewModel = HabitualViewModel(habitual: habituals[indexPath.row])
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension HomeController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = AddHabitualController()
        controller.habitual = habituals[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 75)
    }
}

// MARK: UNUserNotificationCenterDelegate

extension HomeController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping                                (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
}
