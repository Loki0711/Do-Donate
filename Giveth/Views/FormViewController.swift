//
//  FormViewController.swift
//  Giveth
//
//  Created by Jack on 06/07/22.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var demo_image1: UIImageView!
    @IBOutlet weak var demo_image2: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var imagePicker: ImagePicker!
    var iImage = 0
    var formObject: UploadData?
    
    var demoImage1 = "", demoImage2 = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.isHidden = true
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
    }
    
    @IBAction func addImage01(_ sender: Any) {
        self.iImage = 0
        self.imagePicker.present(from: sender as! UIView)
    }
    
    @IBAction func addImage02(_ sender: Any) {
        self.iImage = 1
        self.imagePicker.present(from: sender as! UIView)
    }
    
    @IBAction func submitNew(_ sender: Any) {
      
        self.validateForm()
        
        
        
    }
    
    func showErrorMessage(message: String) {
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alertView.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { alert in
            alertView.dismiss(animated: true)
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func validateForm(){
        
        guard let name = self.nameTF.text, name != "" else {
            showErrorMessage(message: "Name field is empty. Please fill it.")
            return
        }
        
        guard let desc = self.descTF.text, desc != "" else {
            showErrorMessage(message: "Description field is empty. Please fill it.")
            return
        }
        
        guard let address = self.addressTF.text, address != "" else {
            showErrorMessage(message: "Address field is empty. Please fill it.")
            return
        }
        
        guard let contact = self.contactTF.text, contact != "" else {
            showErrorMessage(message: "Contact field is empty. Please fill it.")
            return
        }
        
        if self.demoImage1.isEmpty{
            showErrorMessage(message: "Please select first image...")
            return
        }
        
        if self.demoImage2.isEmpty{
            showErrorMessage(message: "Please select second image...")
            return
        }
        
        self.formObject = UploadData(name: name, contact: contact, description: desc, address: address, image1: self.demoImage1, image2: self.demoImage2, email: UserDefaults.standard.string(forKey: "loggedInEntity") ?? "")
        
        self.uploadDataToFirebase()
        
    }
    
    func uploadDataToFirebase(){
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        if let formObject = self.formObject {
            
            FirebaseService.uploadData(formObject: formObject, emailID: UserDefaults.standard.string(forKey: "loggedInEntity")!)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            let alertView = UIAlertController(title: "Success", message: "Form Inserted Successfully!", preferredStyle: UIAlertController.Style.alert)
            alertView.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { alert in
                alertView.dismiss(animated: true)
                self.dismiss(animated: true)
            }))
            self.present(alertView, animated: true, completion: nil)
            
            
        }
    }
    
    
    
}

extension FormViewController: ImagePickerDelegate {
    func didSelect(fileName: String, image: UIImage?) {
        switch self.iImage {
        case 0:
            self.demo_image1.image = image
            //let imageData:NSData = image!.pngData()! as NSData
            //let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            //self.demoImage1 = strBase64
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            FirebaseService.uploadMedia(imageName: fileName, image: self.demo_image1.image) { url in
                self.demoImage1 = url!
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            
        case 1:
            self.demo_image2.image = image
            //let imageData:NSData = image!.pngData()! as NSData
            //let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            //self.demoImage2 = strBase64
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            FirebaseService.uploadMedia(imageName: fileName, image: self.demo_image1.image) { url in
                self.demoImage2 = url!
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        default:
            break
        }
    }
    
}
