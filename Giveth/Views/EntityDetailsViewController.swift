//
//  EntityDetailsViewController.swift
//  Giveth
//
//  Created by Jagsifat Makkar on 2022-01-23.
//

import UIKit

class EntityDetailsViewController: UIViewController {
    
    var entity : Entity? = nil
    
    var restaurantEntity: RestaurantUser?
    var charityEntity: CharityUser?
    
    var loggedInEntity : Entity? = nil
    @IBOutlet weak var connectButton: UIButton!
    private let coreDBHelper = CoreDBHelper.getInstance()
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if charityEntity != nil {
            self.loadCharityVC()
        } else if restaurantEntity != nil {
            self.loadResVC()
        }
    }
    
    func loadCharityVC(){
        let charityVC  = storyboard?.instantiateViewController(withIdentifier: "CharityVC") as! CharityDetailsViewController
        charityVC.charityEntity = charityEntity
        self.addChild(charityVC)
        charityVC.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
        self.containerView.addSubview(charityVC.view)
        charityVC.didMove(toParent: self)
    }
    
    func loadResVC(){
        let resVC  = storyboard?.instantiateViewController(withIdentifier: "RestaurantVC") as! RestaurantDetailsViewController
        resVC.entity = entity
        self.addChild(resVC)
        resVC.view.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.size.width, height: self.containerView.frame.size.height)
        self.containerView.addSubview(resVC.view)
        resVC.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loggedInEntity = self.coreDBHelper.getEntityByName(UserDefaults.standard.string(forKey: "loggedInEntity") ?? "")
        if Bool(self.entity?.connectionRequests?.contains(self.loggedInEntity?.name ?? "") ?? false)  {
            self.connectButton.setTitle("Cancel Request", for: .normal)
        }
        else if Bool(self.entity?.connections?.contains(self.loggedInEntity?.name ?? "") ?? false){
            self.connectButton.setTitle("Disconnect", for: .normal)
        }
    }

    @IBAction func connectPressed(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let formVC = storyboard.instantiateViewController(identifier: "FormVC") as! FormViewController
            self.present(formVC, animated: true)
        /*
        if sender.titleLabel?.text == "Connect" {
            self.coreDBHelper.updateEntityConnectionRequests(loggedInEntity?.name ?? "", entity?.name ?? "")
            sender.setTitle("Cancel Request", for: .normal)
        }
        else if sender.titleLabel?.text == "Disconnect"{
            self.coreDBHelper.deleteConnection(self.loggedInEntity?.name ?? "", entity?.name ?? "")
            sender.setTitle("Connect", for: .normal)
        }
        else{
            self.coreDBHelper.deleteConnectionRequest(self.loggedInEntity?.name ?? "", entity?.name ?? "")
            sender.setTitle("Connect", for: .normal)
        }
         */
    }
    
    
    
}
