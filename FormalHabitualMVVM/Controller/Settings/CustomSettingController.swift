//
//  CustomSettingController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/12/20.
//

import UIKit
import SnapKit

class CustomSettingController: UIViewController {
    
    // MARK: Properties
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "buttonTintColor")
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private let customSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom settings"
        label.textColor = UIColor(named: "labelColor")
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let darkModeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let darkModeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "다크모드"
        return label
    }()
    
    let darkModeSwitch: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = UIColor(named: "switchOnTintColor")
        sw.thumbTintColor = UIColor(named: "switchThumbTintColor")
        sw.addTarget(self, action: #selector(handleSwitchButton(sender:)), for: .touchUpInside)
        return sw
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        UserDefaults.standard.bool(forKey: "darkModeSwitchStats")
        
        self.navigationController?.isNavigationBarHidden = true
        
        view.addSubview(previousButton)
        previousButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(24)
        }
        
        view.addSubview(customSettingsLabel)
        customSettingsLabel.snp.makeConstraints { make in
            make.top.equalTo(previousButton.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(24)
        }
        
        view.addSubview(darkModeView)
        darkModeView.snp.makeConstraints { make in
            make.top.equalTo(customSettingsLabel.snp.bottom).offset(32)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(24)
            make.width.equalTo(view.frame.width - 50)
            make.height.equalTo(65)
        }
        
        view.addSubview(darkModeTitle)
        darkModeTitle.snp.makeConstraints { make in
            make.centerY.equalTo(darkModeView.snp.centerY)
            make.leading.equalTo(darkModeView.snp.leading).offset(20)
        }
        
        view.addSubview(darkModeSwitch)
        darkModeSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(darkModeView.snp.centerY)
            make.right.equalTo(darkModeView.snp.right).offset(-20)
        }
    }
    
    // MARK: Actions
    
    @objc func handleDismissal(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSwitchButton(sender: UISwitch) {
        UserDefaults.standard.set(darkModeSwitch.isOn, forKey: "darkModeSwitchStats")
        
        if sender.isOn {
//            let bool: () = darkModeSwitch.isOn = true
            if let window = UIApplication.shared.windows.first {
//                UserDefaults.standard.set(bool, forKey: "isOnSwitch")
                window.overrideUserInterfaceStyle = .dark
            }
        } else {
//            let bool: () = darkModeSwitch.isOn = false
            if let window = UIApplication.shared.windows.first {
//                UserDefaults.standard.set(bool, forKey: "isOffSwitch")
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
}
