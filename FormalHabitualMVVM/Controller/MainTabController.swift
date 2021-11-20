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
        didSet {
//            guard let user = user else { return }
        }
        
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
        let home = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselectedHome"), selectedImage: #imageLiteral(resourceName: "selectedHome"), rootViewController: HomeController(collectionViewLayout: layout))
        
        let chart = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselectedChart"), selectedImage: #imageLiteral(resourceName: "selectedChart"), rootViewController: TipController())
        
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
    
    /*
    func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                
                let controller = AddHabitualController()
                controller.delegate = self
                controller.selectedImage = selectedImage
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }
    */
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
