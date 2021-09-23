//
//  SettingHeader.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/10.
//

import UIKit
import SafariServices

class SettingHeader: UITableViewHeaderFooterView {
    
    // MARK: Properties
    
    var viewModel: SettingHeaderViewModel? {
        didSet { configure() }
    }
    
    var user: User? {
        didSet { fetchUser() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "plus_photo")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Jong Won Baek", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        return button
    }()

    
    // MARK: API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.profileButton.setTitle(user.fullname, for: .normal)
            self.profileImageView.sd_setImage(with: self.viewModel?.profileImageUrl)
        }
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileButton.setTitle(viewModel.fullname, for: .normal)
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
    
    // MARK: Actions
    
    @objc func handleProfile() {
        let profileLayout = UICollectionViewFlowLayout()
        let controller = ProfileController(collectionViewLayout: profileLayout)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
     }
    
    // MARK: Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, paddingTop: 25, paddingLeft: 20, paddingBottom: 25)
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        
        addSubview(profileButton)
        profileButton.anchor(left: profileImageView.rightAnchor, paddingTop: 25, paddingBottom: 25)
        profileButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
