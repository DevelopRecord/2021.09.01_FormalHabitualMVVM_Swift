//
//  SettingFooter.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/10.
//

import UIKit
import SafariServices

class SettingFooter: UITableViewHeaderFooterView {
    
    // MARK: Properties
    
    private let tistoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("티스토리", for: .normal)
        button.addTarget(self, action: #selector(tistoryOnSafari), for: .touchUpInside)
        return button
    }()
    
    private let githubButton: UIButton = {
        let button = UIButton()
        button.setTitle("깃허브", for: .normal)
        button.addTarget(self, action: #selector(githubOnSafari), for: .touchUpInside)
        return button
    }()
    
    // MARK: Actions
    
    @objc func tistoryOnSafari() {
        print("DEBUG: Tistory button did tap..")
        
        guard let url = URL(string: "https://ondevelop.tistory.com") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .fullScreen
//        present(safariViewController, animated: true, completion: nil)
        
    }
    
    @objc func githubOnSafari() {
        print("DEBUG: Github button did tap..")
        
        guard let url = URL(string: "https://github.com/DevelopRecord") else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .fullScreen
//        present(safariViewController, animated: true, completion: nil)
        
    }
    
    // MARK: Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(tistoryButton)
        tistoryButton.anchor(left: leftAnchor, paddingTop: 12)
        
        addSubview(githubButton)
        githubButton.anchor(top: tistoryButton.bottomAnchor, left: leftAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    
}
