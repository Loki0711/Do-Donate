//
//  ViewController.swift
//  Giveth
//
//  Created by Jagsifat Makkar on 2022-01-23.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    private let coreDBHelper = CoreDBHelper.getInstance()
    private var entityList = [Entity]()
    var playerLooper : AVPlayerLooper? = nil

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var rememberMeLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Temporary variables
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleImage.image = UIImage(named: "do_donate_login")
//        self.displayVideo()
        self.emailTextField.layer.zPosition = 1
        self.rememberMeSwitch.layer.zPosition = 1
        self.passwordTextField.layer.zPosition = 1
        self.loginButton.layer.zPosition = 1
        self.signUpButton.layer.zPosition = 1
        self.rememberMeLabel.layer.zPosition = 1
        self.titleImage.layer.zPosition = 1
        if UserDefaults.standard.bool(forKey: "rememberMe"){
            self.login()
        }
    }
    
    private func displayVideo() {
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
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        let loginBody = LoginUser(email: email, password: password)
        
        FirebaseService.logInUser(loginObject: loginBody) { result in
            switch result {
            case .success(let user):
                print("User succesfully logged -> \(user.displayName ?? "")")
                AuxiliarFuncitons.saveLocalUserEmail(email: email)
                self.login()
            case .failure(let error):
                print("Login failed -> \(error)")
                let alert = UIAlertController(title: "Login Failed", message: "Invalid Credentials", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    private func login(){
        if rememberMeSwitch.isOn{
            UserDefaults.standard.set(true, forKey: "rememberMe")
        }else{
            UserDefaults.standard.set(false, forKey: "rememberMe")
        }
        FirebaseService.loadCharityUsers { charityUsers in
            for charityUser in charityUsers {
                if charityUser.email == AuxiliarFuncitons.loadLocalUserEmail() {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let tabBarHomePageC = storyboard.instantiateViewController(withIdentifier: "TabBarHomePage")
                    AuxiliarFuncitons.saveIsCharityProperty(true)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarHomePageC)
                }
            }
        }
        FirebaseService.loadRestaurantUsers { restaurantUsers in
            for restaurantUser in restaurantUsers {
                if restaurantUser.email == AuxiliarFuncitons.loadLocalUserEmail() {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let tabBarHomePageC = storyboard.instantiateViewController(withIdentifier: "TabBarHomePage")
                    AuxiliarFuncitons.saveIsCharityProperty(false)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarHomePageC)
                }
            }
        }
    }
}

