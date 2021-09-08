//
//  SettingController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import SafariServices
import Firebase

private let reusableIdentifier = "cell"

class SettingController: UITableViewController {
    
    // MARK: Properties
    private let settingItems: [String] = [ "푸시 알림 설정", "계정 설정", "앱 버전"]
    private let addItems: [String] = ["이용약관", "개인정보처리방침", "FAQ", "고객센터"]
    private let sections: [String] = ["설정", "더보기"]
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 110))
        
        header.backgroundColor = .systemBackground
        footer.backgroundColor = .systemBackground
        
        let myPageButton = UIButton(type: .system)
        myPageButton.setTitle("로그아웃", for: .normal)
        myPageButton.titleLabel?.font = .systemFont(ofSize: 22)
        myPageButton.backgroundColor = .systemBackground
        myPageButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        header.addSubview(myPageButton)
        myPageButton.translatesAutoresizingMaskIntoConstraints = false
        myPageButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20).isActive = true
        myPageButton.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        myPageButton.addTarget(self, action: #selector(handleMyPage), for: UIControl.Event.touchUpInside)
        
        let tistoryButton = UIButton()
        tistoryButton.setTitle("티스토리", for: UIControl.State.normal)
        tistoryButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        footer.addSubview(tistoryButton)
        tistoryButton.translatesAutoresizingMaskIntoConstraints = false
        tistoryButton.addTarget(self, action: #selector(tistoryOnSafari), for: UIControl.Event.touchUpInside)
        
        let githubLabel = UIButton()
        githubLabel.setTitle("깃허브", for: UIControl.State.normal)
        githubLabel.setTitleColor(UIColor.black, for: UIControl.State.normal)
        footer.addSubview(githubLabel)
        githubLabel.translatesAutoresizingMaskIntoConstraints = false
        githubLabel.addTarget(self, action: #selector(githubOnSafari), for: UIControl.Event.touchUpInside)
        
        let imageView1: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "tistory")
            return imageView
        }()
        imageView1.frame = CGRect(x: 20, y: 0, width: 30, height: 30)
        footer.addSubview(imageView1)
        tistoryButton.leadingAnchor.constraint(equalTo: imageView1.leadingAnchor, constant: 40).isActive = true
        tistoryButton.centerYAnchor.constraint(equalTo: imageView1.centerYAnchor).isActive = true
        
        let imageView2: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "github")
            return imageView
        }()
        imageView2.frame = CGRect(x: 20 , y: 50, width: 30, height: 30)
        footer.addSubview(imageView2)
        githubLabel.leadingAnchor.constraint(equalTo: imageView2.leadingAnchor, constant: 40).isActive = true
        githubLabel.centerYAnchor.constraint(equalTo: imageView2.centerYAnchor).isActive = true
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
    }
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        
        tableView.register(TableCell.self, forCellReuseIdentifier: reusableIdentifier)
        tableView.separatorInset.right = 16
    }
    
    // MARK: Selectors
    @objc func handleMyPage() {
        let profileLayout = UICollectionViewFlowLayout()
        let controller = ProfileController(collectionViewLayout: profileLayout)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
//        do {
//            try Auth.auth().signOut()
//            let controller = LoginController()
//            let nav = UINavigationController(rootViewController: controller)
//            nav.modalPresentationStyle = .fullScreen
//            self.present(nav, animated: true, completion: nil)
//        } catch {
//            print("DEBUG: Failed to sign out")
//        }
     }
    
    @objc func tistoryOnSafari() {
        guard let url = URL(string: "https://ondevelop.tistory.com") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
    @objc func githubOnSafari() {
        guard let url = URL(string: "https://github.com/DevelopRecord") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}

extension SettingController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        view.backgroundColor = .systemBackground
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.text = sections[section]
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        view.addSubview(lbl)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! TableCell // 타입 변환을 TableCell이라고 명시해야 합니다.
        
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
