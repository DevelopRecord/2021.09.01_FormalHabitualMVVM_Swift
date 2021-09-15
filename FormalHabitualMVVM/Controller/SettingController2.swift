//
//  SettingController2.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/14.
//

import UIKit

private let cellIdentifier = "SettingCell"
private let headerIdentifier = "SettingHeader"
private let footerIdentifier = "SettingFooter"

class SettingController2: UITableViewController {
    
    // MARK: Properties
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    // MARK: Helpers
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(SettingHeader.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(SettingFooter.self, forHeaderFooterViewReuseIdentifier: footerIdentifier)
    }
    
}

// MARK: UITableViewDataSource

protocol UITableViewDataSource {
    
}

extension SettingController2: UITableViewDataSource {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingCell
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

// MARK: UITableViewDelegate

protocol UITableViewDelegate {
    
}

extension SettingController2: UITableViewDelegate {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
