//
//  HomePageVC.swift
//  Giveth
//
//  Created by David Niño on 14/06/22.
//

import UIKit

class HomePageVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lblWelcomeUser: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Has Restaurants
    var restaurantLoggedEntity: RestaurantUser?
    var restaurantEntities = [RestaurantUser]()
    
    //MARK: Has Charities
    var charityLoggedEntity: CharityUser?
    var charityEntities = [CharityUser]()
    
    var userName = ""
    var didShowWelcome = false
    var isCharityUser = false
    
    //MARK: TABLE VIEW CELL INDEX PATH + ANIMATION
    var animationsQueue = ChainedAnimationsQueue()
    var arrIndexPath = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuView.isHidden = true
        self.menuView.frame.size.width = self.view.frame.width/2
        
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.title = "Welcome, FOODSHARES"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if !didShowWelcome {
//            self.showWelcomeName()
//            self.didShowWelcome = true
//        }
    }
    
    func retrieveUsers() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        let alreadySavedEmail = AuxiliarFuncitons.loadLocalUserEmail()
        FirebaseService.loadCharityUsers { charityUsers in
            self.charityEntities = charityUsers
            for charityUser in charityUsers {
                if charityUser.email == alreadySavedEmail {
                    self.isCharityUser = true
                    self.charityLoggedEntity = charityUser
                    let url = URL(string: charityUser.imageUrl ?? "") ?? URL(string: "https://comnplayscience.eu/app/images/notfound.png")!
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.lblWelcomeUser.text = "Welcome, \(charityUser.getName())"
                        self.username.text = charityUser.getName()
                        self.imageUser.image = UIImage(data: data ?? Data())
                        self.tableView.reloadData()
                    }
                    return
                }
            }
        }
        /*
         FirebaseService.loadRestaurantUsers { restaurantUsers in
            self.restaurantEntities = restaurantUsers
            for restaurantUser in restaurantUsers {
                if restaurantUser.email == alreadySavedEmail {
                    self.isCharityUser = false
                    self.restaurantLoggedEntity = restaurantUser
                    let url = URL(string: restaurantUser.imageUrl ?? "") ?? URL(string: "https://comnplayscience.eu/app/images/notfound.png")!
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.lblWelcomeUser.text = "Welcome, \(restaurantUser.getName())"
                        self.username.text = restaurantUser.getName()
                        self.imageUser.image = UIImage(data: data ?? Data())
                        self.tableView.reloadData()
                    }
                    return
                }
            }
        }*/
    }
    
    func initialSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "EntityCell", bundle: nil), forCellReuseIdentifier: "EntityCell")
        self.userName = UserDefaults.standard.string(forKey: "loggedInEntity") ?? ""
        self.retrieveUsers()
    }
    
    func showWelcomeName(){
        let alert = UIAlertController(title: "Welcome", message: "You log in as \(self.userName)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func goToUserProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let modifyVC = storyboard.instantiateViewController(identifier: "ModifyinfoViewController") as! ModifyinfoViewController
        modifyVC.didChangeCharityInfo = { entity in
            self.lblWelcomeUser.text = "Welcome, \(entity.getName())"
        }
        modifyVC.didChangeRestaurantInfo = { entity in
            self.lblWelcomeUser.text = "Welcome, \(entity.getName())"
        }
        self.navigationController?.pushViewController(modifyVC, animated: true)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
       /* UserDefaults.standard.set("", forKey: "loggedInEntity")
        UserDefaults.standard.set(false, forKey: "rememberMe")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(identifier: "Login") as! LoginViewController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)*/
    }
    
    //MARK: HAMBURGER MENU CLICK ACTION
    @IBAction func ttgPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "donationModeIsOn")
        
        if menuView.isHidden == false {
            menuView.isHidden = true
        } else {
            menuView.isHidden = false
        }
        
        /*let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let connectionsVC = storyboard.instantiateViewController(identifier: "Connections") as! ConnectionsTableViewController
        self.navigationController?.pushViewController(connectionsVC, animated: true)*/
    }
    
    @IBAction func menuTTG(_ sender: Any) {
        menuView.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let connectionsVC = storyboard.instantiateViewController(identifier: "Connections") as! ConnectionsTableViewController
        self.navigationController?.pushViewController(connectionsVC, animated: true)
    }
    @IBAction func menuProfileSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let modifyVC = storyboard.instantiateViewController(identifier: "ModifyinfoViewController") as! ModifyinfoViewController
        modifyVC.didChangeCharityInfo = { entity in
            self.lblWelcomeUser.text = "Welcome, \(entity.getName())"
        }
        modifyVC.didChangeRestaurantInfo = { entity in
            self.lblWelcomeUser.text = "Welcome, \(entity.getName())"
        }
        self.navigationController?.pushViewController(modifyVC, animated: true)
    }
    
    @IBAction func menuAbout(_ sender: Any) {
        menuView.isHidden = true
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let connectionsVC = storyboard.instantiateViewController(identifier: "AboutVC") as! AboutUsViewController
        self.present(connectionsVC, animated: true)
        
    }
    
    @IBAction func menuLogout(_ sender: Any) {
        menuView.isHidden = true
        UserDefaults.standard.set("", forKey: "loggedInEntity")
        UserDefaults.standard.set(false, forKey: "rememberMe")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(identifier: "Login") as! LoginViewController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
    }
    
}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isCharityUser ? self.charityEntities.count : self.restaurantEntities.count
    }
    
    //MARK: TABLE CELL VIEW LOAD ANIMATION
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.arrIndexPath.contains(indexPath) == false {
            cell.alpha = 0.0
            animationsQueue.queue(withDuration: 0.1, initializations: {
              cell.layer.transform = CATransform3DTranslate(CATransform3DIdentity, cell.frame.size.width, 0, 0)
            }, animations: {
              cell.alpha = 1.0
              cell.layer.transform = CATransform3DIdentity
            })
            self.arrIndexPath.append(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isCharityUser {
            let entity = self.charityEntities[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "EntityCell", for: indexPath) as! EntityCell
            let url = URL(string: entity.imageUrl ?? "") ?? URL(string: "https://comnplayscience.eu/app/images/notfound.png")!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.name?.text = entity.getName()
                cell.imageEntity.image = UIImage(data: data ?? Data())
                cell.isConnected.text = entity.description
            }
            return cell
        }
        
        if !isCharityUser {
            let entity = self.restaurantEntities[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "EntityCell", for: indexPath) as! EntityCell
            let url = URL(string: entity.imageUrl ?? "") ?? URL(string: "https://comnplayscience.eu/app/images/notfound.png")!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.name?.text = entity.getName()
                cell.imageEntity.image = UIImage(data: data ?? Data())
                cell.isConnected.text = entity.description
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: Pending to make it work
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let entityDetailsVC = storyboard.instantiateViewController(identifier: "EntityDetails") as! EntityDetailsViewController
        if isCharityUser {
            entityDetailsVC.charityEntity = self.charityEntities[indexPath.row]
        }
        if !isCharityUser {
            entityDetailsVC.restaurantEntity = self.restaurantEntities[indexPath.row]
        }
        self.navigationController?.pushViewController(entityDetailsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
