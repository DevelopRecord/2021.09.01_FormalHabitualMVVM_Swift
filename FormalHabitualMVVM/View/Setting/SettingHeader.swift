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
    
    private let tistoryImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "tistory")
        iv.setDimensions(height: 30, width: 30)
        return iv
    }()
    
    private let githubImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "github")
        iv.setDimensions(height: 30, width: 30)
        return iv
    }()
    
    // Actions
    
    @objc func handleProfile() {
        let profileLayout = UICollectionViewFlowLayout()
        let controller = ProfileController(collectionViewLayout: profileLayout)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true, completion: nil)
        
        /*
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out")
        }
         */
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
    
    // MARK: Helpers
    
    
}
