//
//  MyPageController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/07.
//

import UIKit
import Firebase
import SnapKit

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

protocol ProfileControllerDelegate: AnyObject {
    func controllerDidChangedPassword(_ controller: ProfileController)
}

protocol ProfileControllerDelegates: AnyObject {
    func controllerDeletedUser()
}

class ProfileController: UICollectionViewController {
    
    // MARK: Properties
    
    private var habituals = [Habitual]()
    private var users: User?
    private var user: User? {
        didSet { collectionView.reloadData() }
    }
    weak var delegate: ProfileControllerDelegate?
    weak var delegates: UserDeleteDelegate?
    var password: String?
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 변경"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0/12"
        return label
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let pushButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("푸시알림", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
        return button
    }()
    
    private let userDeleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleUserDeleteButton), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(UIColor(named: "profileSaveButtonTitleColor"), for: .normal)
        button.backgroundColor = UIColor(named: "profileSaveButtonBackgroundColor")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        self.hideKeyboardWhenTappedAround()
        fetchUser()
        fetchHabituals()
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "labelColor")
    }
    
    // MARK: API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = "프로필"
        }
    }
    
    func fetchHabituals() {
        guard let user = users else { return }
        HabitualService.fetchHabituals(forUser: user.uid) { habituals in
            self.habituals = habituals
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Helpers
    
    func configureCollectionView() {
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        hidesBottomBarWhenPushed = true
        
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stack.axis = .vertical
        stack.spacing = 10
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(210)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
            make.height.equalTo(100)
        }
        
        view.addSubview(characterCountLabel)
        characterCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(220)
            make.right.equalTo(view.snp.right).offset(-15)
        }
        
        let bottomDivider = UIView()
        bottomDivider.backgroundColor = UIColor(named: "dividerBackgroundColor")

        view.addSubview(bottomDivider)
        bottomDivider.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(10)
        }
        
        view.addSubview(pushButton)
        pushButton.snp.makeConstraints { make in
            make.top.equalTo(bottomDivider.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(50)
        }
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(pushButton.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(50)
        }
        
        view.addSubview(userDeleteButton)
        userDeleteButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(50)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view.snp.right)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(55)
        }
    }
    
    
    // MARK: Actions
    
    @objc func handleLogoutButton() {
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
    
    @objc func handleUserDeleteButton() {
        
        self.showLoader(true)
        AuthService.deleteUser { error in
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                self.showLoader(false)
                return
            }
            
            self.delegates?.userDeleteDidComplete()
        }
    }
    
    @objc func handleSaveButton() {
        guard let password = passwordTextField.text else { return }
        
        self.showLoader(true)
        AuthService.changePassword(password: password) { error in
            if let error = error {
                self.showMessage(withTitle: "Error", message: error.localizedDescription)
                self.showLoader(false)
                return
            }
            
            self.delegate?.controllerDidChangedPassword(self)
        }
    }
}


// MARK: UICollectionViewDataSource

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habituals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        }
        return header
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
}

