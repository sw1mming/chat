//
//  RegisterViewController+ImagePicker.swift
//  FindYours
//
//  Created by Melnik Sergey on 8/22/19.
//  Copyright © 2019 FindYours. All rights reserved.
//

import UIKit

extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func showImagePickerActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { _ in
            showPicker(sourceType: .photoLibrary)
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                showPicker(sourceType: .camera)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)

        func showPicker(sourceType: UIImagePickerController.SourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            registerView.avatarImageView.image = image
            interactor.chooseAvatar(request: Register.ChooseAvatar.Request(image: image))
        }

        picker.dismiss(animated: true)
    }
}
