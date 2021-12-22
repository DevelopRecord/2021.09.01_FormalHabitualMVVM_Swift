//
//  MainTabController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController {
    
    // MARK: Lifecycle
    
    private var user: User? {
        didSet { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        configureViewControllers()
    }
    
    // MARK: API
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        }
    }
    
    // MARK: Helper
    
    func configureViewControllers() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        let home = templateNavigationController(selectedImage: #imageLiteral(resourceName: "selectedHome"),
                                                rootViewController: HomeController(collectionViewLayout: layout))
        
        let chart = templateNavigationController(selectedImage: #imageLiteral(resourceName: "selectedChart"), rootViewController: TipController())
        
        let setting = templateNavigationController(selectedImage: #imageLiteral(resourceName: "selectedUser"),
                                                   rootViewController: SettingController())
        
        viewControllers = [home, chart, setting]
        tabBar.tintColor = UIColor(named: "kakaoColor")
        tabBar.unselectedItemTintColor = .systemGray3
    }
    
    func templateNavigationController(selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = selectedImage
        return nav
    }
}

// MARK: AuthentificationDelegate

extension MainTabController: AuthentificationDelegate {
    func authentificationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: AddHabitualControllerDelegate

extension MainTabController: AddHabitualControllerDelegate {
    func controllerDidFinishUploadingHabitual(_ controller: AddHabitualController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        
        guard let homeNav = viewControllers?.first as? UINavigationController else { return }
        guard let home = homeNav.viewControllers.first as? HomeController else { return }
        home.handleRefresh()
    }
}
