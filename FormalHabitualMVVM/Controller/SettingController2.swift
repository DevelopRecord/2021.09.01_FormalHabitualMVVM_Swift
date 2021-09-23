//
//  SettingController2.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/14.
//

import UIKit
import SafariServices
import Firebase
import SDWebImage

private let cellIdentifier = "SettingCell"
private let headerIdentifier = "SettingHeader"
private let footerIdentifier = "SettingFooter"

class SettingController2: UITableViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    // MARK: Properties
    
//    var viewModel: SettingHeaderViewModel? {
//        didSet { configure() }
//    }
    
    var user: User? {
        didSet { tableView.reloadData() }
    }
    
    private let settingItems: [String] = [ "푸시 알림 설정", "계정 설정", "앱 버전"]
    private let addItems: [String] = ["이용약관", "개인정보처리방침", "FAQ", "고객센터"]
    private let sections: [String] = ["설정", "더보기"]
    
    // MARK: API
    
    
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorInset.right = 16
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(SettingHeader.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(SettingFooter.self, forHeaderFooterViewReuseIdentifier: footerIdentifier)
    }
    
}

// MARK: UITableViewDataSource

extension SettingController2 {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return settingItems.count
        } else if section == 1 {
            return addItems.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! SettingHeader
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        cell.backgroundColor = .white
        return cell
        
        

//        view.backgroundColor = .systemBackground
//        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
//        lbl.text = sections[section]
//        lbl.font = UIFont.boldSystemFont(ofSize: 17)
//        view.addSubview(lbl)
//        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingCell
        
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(settingItems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(addItems[indexPath.row])"
        } else {
            return UITableViewCell()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerIdentifier) as! SettingFooter
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SettingController2: AuthentificationDelegate {
    func authentificationDidComplete() {
        print("DEBUG: Setting controller auth did complete. Fetch user and update here..")
        self.dismiss(animated: true, completion: nil)
    }
}
