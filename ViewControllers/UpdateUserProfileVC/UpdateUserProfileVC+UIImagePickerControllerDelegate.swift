//
//  UpdateUserProfileVC+UIImagePickerControllerDelegate.swift
//  Quick-Grub2
//
//  Created by Mr Wonderful on 3/13/20.
//  Copyright © 2020 Mr Wonderful. All rights reserved.
//

import UIKit

extension UpdateUserProfileViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private func storeUserInputImage(imageData:Data){
        FirebaseStorageService.manager.storeUserInputImage(image: imageData, completion: { [weak self] (result) in
            switch result{
            case .success(let url):
                (self?.imageURL = url)!
                self?.updateButton.isEnabled = true
                self?.updateButton.backgroundColor = .blue
            case .failure(let error):
                self?.showAlert(alertTitle: "Error", alertMessage: "Ran into issues saving your image to the database, please try again \(error)", actionTitle: "OK")
            }
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            self.showAlert(alertTitle: "Error", alertMessage: "Cant edit image", actionTitle: "OK")
            return
        }
        profileImage.image = image
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            return
        }
        storeUserInputImage(imageData: imageData)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        updateButton.isEnabled = true
        updateButton.backgroundColor = .blue
        picker.dismiss(animated: true, completion: nil)
    }
}
