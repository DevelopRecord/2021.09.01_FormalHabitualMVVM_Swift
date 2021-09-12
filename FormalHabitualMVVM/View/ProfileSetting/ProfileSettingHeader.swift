//
//  ProfileSettingHeader.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/12.
//

import UIKit

class ProfileSettingHeader: UITableViewHeaderFooterView {
    
    // MARK: Properties
    
    private var profileImage: UIImage?
    
    private let modifyPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo-1"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        return button
    }()
    
    // MARK: Actions
    
    @objc func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
//        present(picker, animated: true, completion: nil)
        
    }
    
    // MARK: Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileSettingHeader: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        modifyPhotoButton.layer.cornerRadius = modifyPhotoButton.frame.width / 2
        modifyPhotoButton.layer.masksToBounds = true
        modifyPhotoButton.layer.borderColor = UIColor.black.cgColor
        modifyPhotoButton.layer.borderWidth = 2
        modifyPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
//        self.dismiss(animated: true, completion: nil)
    }
}
