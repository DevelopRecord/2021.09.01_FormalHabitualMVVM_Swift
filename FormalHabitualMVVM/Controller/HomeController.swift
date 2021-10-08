//
//  HomeController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import Firebase

private let reusableIdentifier = "Cell"

class HomeController: UICollectionViewController {
    
    let timeSelector : Selector = #selector(HomeController.updateTime)
    let interval = 1.0
    var count = 0
    
    // MARK: Properties
    
    private var habituals = [Habitual]()
    
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
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    // MARK: API
    
    func fetchHabituals() {
        HabitualService.fetchHabituals { habituals in
            self.habituals = habituals
            self.collectionView.reloadData()
        }
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
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "M.dd (E) h:mm a"
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.locale = Locale(identifier: "ko_kr")
        currentTimeLabel.text = formatter.string(from: date as Date)
    }
    
    // MARK: Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: reusableIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "로그아웃",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogout))
        
        
        collectionView.addSubview(currentTimeLabel)
        currentTimeLabel.anchor(top: collectionView.topAnchor, left: collectionView.leftAnchor,
                                paddingTop: 12, paddingLeft: 12)
        
        collectionView.addSubview(addButton)
        addButton.setDimensions(height: 55, width: 55)
        addButton.anchor(bottom: collectionView.safeAreaLayoutGuide.bottomAnchor,
                         right: collectionView.safeAreaLayoutGuide.rightAnchor,
                         paddingBottom: 20, paddingRight: 20)
        
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

// MARK: UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 75)
    }
}
