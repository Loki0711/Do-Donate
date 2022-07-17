//
//  RegisterViewController.swift
//  Giveth
//
//  Created by David Niño on 05/06/22.
//

import UIKit
import AVFoundation

class RegisterViewController: UIViewController {
    
    static let storyboard = "Main"
    static let identifier = "RegisterViewController"
    
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var stackFields: UIStackView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnCharity: UIButton!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var imageCharity: UIImageView!
    @IBOutlet weak var viewCharity: UIView!
    
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    var isForCharity = true
    
    @IBOutlet weak var imageUser: UIImageView!
    
    var registerObject: RegisterUser?
    var playerLooper : AVPlayerLooper? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.displayVideoView()
        self.setupUI()
        AuxiliarFuncitons.saveIsCharityProperty(self.isForCharity)
    }
    
    @IBAction func accountTypeTapped(_ sender: UIButton) {
        //Tag  0 -> Charity
        if sender.tag == 0 {
            self.isForCharity = true
            AuxiliarFuncitons.saveIsCharityProperty(true)
            self.imageCharity.image = UIImage(systemName: "circle.circle")
            self.imageUser.image = UIImage(systemName: "circle")
            return
        }
        //Tag 1 -> User
        if sender.tag == 1 {
            self.isForCharity = false
            AuxiliarFuncitons.saveIsCharityProperty(false)
            self.imageUser.image = UIImage(systemName: "circle.circle")
            self.imageCharity.image = UIImage(systemName: "circle")
            return
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        self.fillRegisterData()
        if let registerObject = self.registerObject {
            FirebaseService.registerUser(registerObject: registerObject) { result in
                switch result {
                case .success(let user):
                    print("User register succesfully")
                    
                    //Retrieve user from database
                    let isCharity = AuxiliarFuncitons.loadIsCharityProperty()
                    if isCharity {
                        let charityUser = CharityUser(name: registerObject.getName(), contact: registerObject.getContact(), address: registerObject.getAddress(), city: registerObject.getCity(), country: registerObject.getCountry(), zipCode: registerObject.getZipCode(), description: registerObject.getDescription(), email: registerObject.getEmail(), password: registerObject.getPwd(), imageUrl: "")
                        FirebaseService.saveRegisterCharity(registerObject: charityUser)
                    } else {
                        
                        let restaurantUser = RestaurantUser(name: registerObject.getName(), contact: registerObject.getContact(), address: registerObject.getAddress(), city: registerObject.getCity(), country: registerObject.getCountry(), zipCode: registerObject.getZipCode(), description: registerObject.getDescription(), email: registerObject.getEmail(), password: registerObject.getPwd(), imageUrl: "")
                        FirebaseService.saveRegisterRestaurant(registerObject: restaurantUser)
                    }
                    UserDefaults.standard.set(registerObject.getEmail(), forKey: "loggedInEntity")
                    self.goToHomeViewController()
                    
                case .failure(let error):
                    self.showErrorMessage(message: error.localizedDescription)
                }
            }
        }
    }
    
    func displayVideoView() {
        let player = AVQueuePlayer()
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(layer)
        let playerItem = AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: "login", ofType: "mp4")!))
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
        player.volume = 0
        player.play()
    }
    
    func setupUI(){
        self.viewCharity.layer.cornerRadius = 10
        self.imageLogo.layer.zPosition = 1
        self.stackFields.layer.zPosition = 1
        self.registerButton.layer.zPosition = 1
    }
    
    func fillRegisterData(){
        guard let name = self.txtName.text, name != "" else {
            showErrorMessage(message: "Name field is empty. Please fill it.")
            return
        }
        guard let contact = self.txtContact.text, contact != ""  else {
            showErrorMessage(message: "Contact field is empty. Please fill it.")
            return
        }
        guard let address = self.txtAddress.text, address != "" else {
            showErrorMessage(message: "Address field is empty. Please fill it.")
            return
        }
        guard let city = self.txtCity.text, city != "" else {
            showErrorMessage(message: "City field is empty. Please fill it.")
            return
        }
        guard let country = self.txtCountry.text, country != "" else {
            showErrorMessage(message: "Country field is empty. Please fill it.")
            return
        }
        guard let zipCode = self.txtZipCode.text, zipCode != "" else {
            showErrorMessage(message: "ZipCode field is empty. Please fill it.")
            return
        }
        guard let description = self.txtDescription.text, description != "" else {
            showErrorMessage(message: "Description field is empty. Please fill it.")
            return
        }
        guard let email = self.txtEmail.text, email != "" else {
            showErrorMessage(message: "Email field is empty. Please fill it.")
            return
        }
        guard let password = self.txtPassword.text, password != "" else {
            showErrorMessage(message: "Password field is empty. Please fill it.")
            return
        }
        let charity = self.isForCharity
        AuxiliarFuncitons.saveIsCharityProperty(charity)
        self.registerObject = RegisterUser(name: name, contact: contact, address: address, city: city, country: country, zipCode: zipCode, description: description, email: email, password: password, isCharity: self.isForCharity)
    }
    
    func showErrorMessage(message: String) {
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alertView.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { alert in
            alertView.dismiss(animated: true)
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func goToHomeViewController() {
        if rememberMeSwitch.isOn{
            UserDefaults.standard.set(true, forKey: "rememberMe")
        }
        else{
            UserDefaults.standard.set(false, forKey: "rememberMe")
        }
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarHomePageC = storyboard.instantiateViewController(withIdentifier: "TabBarHomePage")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarHomePageC)
    }
}
