//
//  SettingController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import Firebase
import SafariServices
import SDWebImage
import SnapKit

private let reusableIdentifier = "cell"
private let settingHeader = "settingHeader"

protocol AuthentificationDelegates: AnyObject {
    func authentificationDidCompletes()
}

class SettingController: UITableViewController {
    
    // MARK: Properties
    
    private var users = [User]()
    weak var delegate: AuthentificationDelegates?
    weak var delegates: ProfileControllerDelegates?
    
    var viewModel: SettingViewModel? {
        didSet { configure() }
    }
    
    var user: User? {
        didSet { tableView.reloadData() }
    }
    
    private let settingItems = [ "앱 버전", "커스텀 설정", "푸시 알림 설정"]
    private let addItems = ["이용약관", "개인정보처리방침", "FAQ", "고객센터"]
    private let sections = ["설정", "더보기"]
    
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.backgroundColor = UIColor(named: "backgroundColor")
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUser()
        fetchUsers()
    }
    
    // MARK: ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
    }
    
    // MARK: API
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        profileButton.setTitle(viewModel.fullname, for: .normal)
    }
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.profileButton.setTitle(user.fullname, for: .normal)
            self.profileImageView.sd_setImage(with: URL(string: user.profileImageUrl))
        }
    }
    
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: Helpers
    
    func configureTableView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        self.navigationItem.title = "환경설정"
        tabBarItem.isEnabled = true
        tableView.separatorColor = UIColor(named: "tabBarBorderColor")
        
        tableView.register(TableCell.self, forCellReuseIdentifier: reusableIdentifier)
        tableView.register(SettingHeader.self, forHeaderFooterViewReuseIdentifier: settingHeader)
        
        
        tableView.separatorInset.right = 16
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 110))
        header.backgroundColor = UIColor(named: "backgroundColor")
        footer.backgroundColor = UIColor(named: "backgroundColor")
        
        header.addSubview(profileImageView)
        profileImageView.layer.cornerRadius = 60 / 2
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(header)
            make.left.equalTo(header.snp.left).offset(20)
            make.width.height.equalTo(60)
        }
        
        let tistoryButton = UIButton()
        tistoryButton.setTitle("티스토리", for: .normal)
        tistoryButton.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        footer.addSubview(tistoryButton)
        tistoryButton.translatesAutoresizingMaskIntoConstraints = false
        tistoryButton.addTarget(self, action: #selector(tistoryOnSafari), for: .touchUpInside)
        
        let githubButton = UIButton()
        githubButton.setTitle("깃허브", for: .normal)
        githubButton.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        footer.addSubview(githubButton)
        githubButton.translatesAutoresizingMaskIntoConstraints = false
        githubButton.addTarget(self, action: #selector(githubOnSafari), for: .touchUpInside)
        
        let imageView1: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "tistory")
            return imageView
        }()
        imageView1.frame = CGRect(x: 20, y: 0, width: 30, height: 30)
        
        footer.addSubview(imageView1)
        tistoryButton.snp.makeConstraints { make in
            make.top.equalTo(footer.snp.bottom).offset(10)
            make.left.equalTo(imageView1.snp.left).offset(40)
            make.centerY.equalTo(imageView1.snp.centerY)
        }
        
        let imageView2: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "github")
            return imageView
        }()
        imageView2.frame = CGRect(x: 20 , y: 50, width: 30, height: 30)
        
        footer.addSubview(imageView2)
        githubButton.snp.makeConstraints { make in
            make.left.equalTo(imageView2.snp.left).offset(40)
            make.centerY.equalTo(imageView2.snp.centerY)
        }
        
        header.addSubview(profileButton)
        profileButton.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.centerY.equalTo(header.snp.centerY)
        }
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
    }
    
    // MARK: Actions
        
    @objc func handleProfile() {
        let controller = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.delegate = self
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
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

// MARK: UITableViewDataSource

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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        view.backgroundColor = UIColor(named: "backgroundColor")
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 100, height: 40))
        lbl.text = sections[section]
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        view.addSubview(lbl)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! TableCell // 타입 변환을 TableCell이라고 명시해야 합니다.
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(named: "backgroundColor")
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(settingItems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(addItems[indexPath.row])"
        } else {
            return UITableViewCell()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: UITableViewDelegate

extension SettingController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("DEBUG: App version..")
        } else if indexPath.row == 1 {
            let controller = CustomSettingController()
            navigationController?.pushViewController(controller, animated: true)
        } else if indexPath.row == 2 {
            print("DEBUG: Push notifications..")
        }
    }
}

// MARK: AuthentificationDelegate

extension SettingController: AuthentificationDelegate {
    func authentificationDidComplete() {
        print("DEBUG: Setting controller auth did complete. Fetch user and update here..")
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: ResetPasswordControllerDelegate

extension SettingController: ProfileControllerDelegate {
    func controllerDidChangedPassword(_ controller: ProfileController) {
        controller.hidesBottomBarWhenPushed = true
        navigationController?.popViewController(animated: true)
        showMessage(withTitle: "Success", message: "회원님의 비밀번호가 변경되었습니다.")
    }
}
