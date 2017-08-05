//
//  EditProfileScreen.swift
//  Step
//
//  Created by Rishi Pochiraju on 3/7/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import HealthKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


var profilePicDidChangeGlobal = false
var didUsernameChange = false

class EditProfileScreen: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var editProfilePicImage: UIImageView!
    var didProfilePicChange = false
    let imagePicker = UIImagePickerController()
    
    let oldUsername = finalUsername
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newScreenName.text = finalScreenName
        newUsername.text = finalUsername
        self.newUsername.delegate = self
        self.newScreenName.delegate = self
        self.hideKeyboardWhenTappedAround()
        saveButtonLabel.isEnabled = false
        newScreenName.addTarget(self, action: #selector(EditProfileScreen.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        newUsername.addTarget(self, action: #selector(EditProfileScreen.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        editProfilePicImage.image = profileImageGlobal.image
        editProfilePicImage.layer.cornerRadius = editProfilePicImage.frame.size.width / 3.3 * self.view.frame.size.width / 414
        editProfilePicImage.clipsToBounds = true
        editProfilePicImage.layer.masksToBounds = true
        editProfilePicImage.layer.borderWidth = 3.0
        editProfilePicImage.layer.borderColor = UIColor.gray.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfileScreen.imageTapped(_:)))
        editProfilePicImage.addGestureRecognizer(tapGesture)
        editProfilePicImage.isUserInteractionEnabled = true
        
        imagePicker.delegate = self
        
    }
    
    func imageTapped(_ gesture: UIGestureRecognizer) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            oldProfileImageGlobal.image = profileImageGlobal.image
            editProfilePicImage.image = pickedImage
            editProfilePicImage.contentMode = .scaleAspectFill
            profileImageGlobal.image = editProfilePicImage.image
            didProfilePicChange = true
            profilePicDidChangeGlobal = true
            saveButtonLabel.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func tap(_ gesture: UITapGestureRecognizer) {
        newScreenName.resignFirstResponder()
        newUsername.resignFirstResponder()
    }
    
    @IBOutlet var saveButtonLabel: UIButton!
    @IBOutlet var newScreenName: UITextField!
    @IBOutlet var newUsername: UITextField!
    
    func textFieldDidChange(_ textField: UITextField) {
        if (newScreenName.text == "" || newUsername.text == "" || (newScreenName.text == finalScreenName && newUsername.text == finalUsername) || newUsername.text?.characters.count < 6){
            if didProfilePicChange == false {
                saveButtonLabel.isEnabled = false
            }else{
                saveButtonLabel.isEnabled = true
            }
        }else{
            saveButtonLabel.isEnabled = true
        }
    }

    
    @IBAction func saveChanges(_ sender: AnyObject) {
        finalUsername = newUsername.text!
        finalScreenName = newScreenName.text!
        if finalUsername != oldUsername {
            didUsernameChange = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeView(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
        //reset the old profile image because we hit cancel
        profileImageGlobal.image = oldProfileImageGlobal.image
        
    }
    
}
