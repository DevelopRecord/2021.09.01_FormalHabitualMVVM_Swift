//
//  MainTabController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        checkedIfUserIsLoggedIn()
    }
    
    // MARK: API
    func checkedIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Helper
    func configureViewController() {
        view.backgroundColor = .white
        
        let home = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselectedHome"), selectedImage: #imageLiteral(resourceName: "selectedHome"), rootViewController: HomeController())
        let chart = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselectedChart"), selectedImage: #imageLiteral(resourceName: "selectedChart"), rootViewController: ChartController())
        let setting = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselectedUser"), selectedImage: #imageLiteral(resourceName: "selectedUser"), rootViewController: SettingController())
        
        viewControllers = [home, chart, setting]
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.image = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}
