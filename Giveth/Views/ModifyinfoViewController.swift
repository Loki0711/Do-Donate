//
//  ModifyinfoViewController.swift
//  Giveth
//
//  Created by David Niño on 15/06/22.
//

import UIKit

class ModifyinfoViewController: UIViewController {

    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var txtCountry: UITextField!
    
    @IBOutlet weak var viewZipCode: UIView!
    @IBOutlet weak var lblZipCode: UILabel!
    @IBOutlet weak var txtZipCode: UITextField!
    
    @IBOutlet weak var viewContact: UIView!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var txtContact: UITextField!
    
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnModify: UIButton!
    
    var goingToEdit = false
    var isCharity = true
    
    var charityLoggedEntity = CharityUser()
    var restaurantLoggedEntity = RestaurantUser()
    
    var didChangeCharityInfo: ((CharityUser) -> Void)?
    var didChangeRestaurantInfo: ((RestaurantUser) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.buildSaveButton()
    }
    
    func initialSetup() {
        //Retrieve user from db
        self.isCharity = AuxiliarFuncitons.loadIsCharityProperty()
        let alreadySavedEmail = AuxiliarFuncitons.loadLocalUserEmail()
        if isCharity {
            FirebaseService.loadCharityUsers { charityUsers in
                for charityUser in charityUsers {
                    if charityUser.email == alreadySavedEmail {
                        self.charityLoggedEntity = charityUser
                        let url = URL(string: charityUser.imageUrl ?? "") ?? URL(string: "https://comnplayscience.eu/app/images/notfound.png")!
                        let data = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            self.lblName.text = charityUser.getName()
                            self.lblAddress.text = charityUser.address
                            self.lblCity.text = charityUser.city
                            self.lblCountry.text = charityUser.country
                            self.lblZipCode.text = charityUser.zipCode
                            self.lblDescription.text = charityUser.description
                            self.imageUser.image = UIImage(data: data ?? Data())
                            
                            self.txtName.text = charityUser.getName()
                            self.txtContact.text = charityUser.contact
                            self.txtAddress.text = charityUser.address
                            self.txtCity.text = charityUser.city
                            self.txtCountry.text = charityUser.country
                            self.txtZipCode.text = charityUser.zipCode
                            self.txtDescription.text = charityUser.description
                        }
                        return
                    }
                }
            }
        } else {
            FirebaseService.loadRestaurantUsers { restaurantUsers in
                for restaurantUser in restaurantUsers {
                    if restaurantUser.email == alreadySavedEmail {
                        self.restaurantLoggedEntity = restaurantUser
                        let url = URL(string: restaurantUser.imageUrl ?? "") ?? URL(string: "https://comnplayscience.eu/app/images/notfound.png")!
                        let data = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            self.lblName.text = restaurantUser.getName()
                            self.lblAddress.text = restaurantUser.address
                            self.lblCity.text = restaurantUser.city
                            self.lblCountry.text = restaurantUser.country
                            self.lblZipCode.text = restaurantUser.zipCode
                            self.lblDescription.text = restaurantUser.description
                            self.imageUser.image = UIImage(data: data ?? Data())
                            
                            self.txtName.text = restaurantUser.getName()
                            self.txtContact.text = restaurantUser.contact
                            self.txtAddress.text = restaurantUser.address
                            self.txtCity.text = restaurantUser.city
                            self.txtCountry.text = restaurantUser.country
                            self.txtZipCode.text = restaurantUser.zipCode
                            self.txtDescription.text = restaurantUser.description
                        }
                        return
                    }
                }
            }
        }
        self.showToNotEdit()
    }
    
    func buildSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem?.customView?.alpha = 0.0
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func saveData() {
        if validateFields() {
            let name = self.txtName.text ?? ""
            let contact = self.txtContact.text ?? ""
            let address = self.txtAddress.text ?? ""
            let city = self.txtCity.text ?? ""
            let country = self.txtCountry.text ?? ""
            let zipCode = self.txtZipCode.text ?? ""
            let description = self.txtDescription.text ?? ""
            let email = self.charityLoggedEntity.email ?? ""
            let password = self.charityLoggedEntity.password ?? ""
            let imageUrl = self.charityLoggedEntity.imageUrl ?? ""
            
            if isCharity {
                let updateObject = CharityUser(name: name, contact: contact, address: address, city: city, country: country, zipCode: zipCode, description: description, email: email, password: password, imageUrl: imageUrl)
                FirebaseService.saveRegisterCharity(registerObject: updateObject)
                let alert = UIAlertController(title: "Successful", message: "Profile updated", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
                    self.navigationController?.popViewController(animated: true)
                    if let didChangeCharityInfo = self.didChangeCharityInfo {
                        didChangeCharityInfo(self.charityLoggedEntity)
                    }
                }))
                self.present(alert, animated: true) {}
                return
            } else {
                let updateObject = RestaurantUser(name: name, contact: contact, address: address, city: city, country: country, zipCode: zipCode, description: description, email: email, password: password, imageUrl: imageUrl)
                FirebaseService.saveRegisterRestaurant(registerObject: updateObject)
                let alert = UIAlertController(title: "Successful", message: "Profile updated", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
                    self.navigationController?.popViewController(animated: true)
                    if let didChangeRestaurantInfo = self.didChangeRestaurantInfo {
                        didChangeRestaurantInfo(self.restaurantLoggedEntity)
                    }
                }))
                self.present(alert, animated: true) {}
                return
            }
        }
    }
    
    func showToEdit() {
        self.txtName.isHidden = false
        self.txtAddress.isHidden = false
        self.txtCity.isHidden = false
        self.txtCountry.isHidden = false
        self.txtZipCode.isHidden = false
        self.txtContact.isHidden = false
        self.txtDescription.isHidden = false
        self.viewName.isHidden = true
        self.viewContact.isHidden = true
        self.viewDescription.isHidden = true
        self.viewAddress.isHidden = true
        self.viewCity.isHidden = true
        self.viewCountry.isHidden = true
        self.viewZipCode.isHidden = true
        
        self.navigationItem.rightBarButtonItem?.customView?.isHidden = false
        
    }
    
    func showToNotEdit() {
        self.txtName.isHidden = true
        self.txtAddress.isHidden = true
        self.txtCity.isHidden = true
        self.txtCountry.isHidden = true
        self.txtZipCode.isHidden = true
        self.txtContact.isHidden = true
        self.txtDescription.isHidden = true
        self.viewName.isHidden = false
        self.viewContact.isHidden = false
        self.viewDescription.isHidden = false
        self.viewAddress.isHidden = false
        self.viewCity.isHidden = false
        self.viewCountry.isHidden = false
        self.viewZipCode.isHidden = false
        
        self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
        
    }
    
    func validateFields() -> Bool {
        guard let name = self.txtName.text, name != "" else {
            self.showErrorAlert(message: "Name field is empty")
            return false
        }
        guard let address = self.txtAddress.text, address != "" else {
            self.showErrorAlert(message: "Address field is empty")
            return false
        }
        guard let contact = self.txtContact.text, contact != "" else {
            self.showErrorAlert(message: "Contact field is empty")
            return false
        }
        guard let description = self.txtContact.text, description != "" else {
            self.showErrorAlert(message: "Description field is empty")
            return false
        }
        return true
    }
    
    func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        self.goingToEdit.toggle()
        if goingToEdit {
            self.btnEdit.setTitle("Cancel", for: .normal)
            self.btnEdit.setTitleColor(.red, for: .normal)
            navigationItem.rightBarButtonItem?.isEnabled = true
            navigationItem.rightBarButtonItem?.customView?.alpha = 1.0
            self.showToEdit()
        } else {
            self.btnEdit.setTitle("Edit Info", for: .normal)
            self.btnEdit.setTitleColor(.systemBlue, for: .normal)
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.rightBarButtonItem?.customView?.alpha = 0.0
            self.showToNotEdit()
        }
    }
    
    

}
