//
//  HomePageTableViewController.swift
//  Giveth
//
//  Created by Jagsifat Makkar on 2022-01-23.
//

import UIKit

class HomePageTableViewController: UITableViewController {
    
    var loggedInEntity : Entity? = nil
    private var entities = [Entity]()
    private let coreDBHelper = CoreDBHelper.getInstance()
    var userName = ""
    
    @IBOutlet var ttgButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var didShowWelcome = false
    
    
    func getEntities(){
        self.loggedInEntity = self.coreDBHelper.getEntityByName(UserDefaults.standard.string(forKey: "loggedInEntity") ?? "")
        if loggedInEntity?.type == "restaurant"{
            self.entities = self.coreDBHelper.getEntitiesForHomePage("charity")!
            self.navigationItem.title = "Charities Around Me"
        }
        else{
            self.navigationItem.leftBarButtonItem = nil
            self.entities = self.coreDBHelper.getEntitiesForHomePage("restaurant")!
            self.navigationItem.title = "Restaurants Around Me"
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 125
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
        UserDefaults.standard.set(false, forKey: "donationModeIsOn")
        tableView.delegate = self
        tableView.dataSource = self
        self.getEntities()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !didShowWelcome {
            self.showWelcomeName()
            self.didShowWelcome = true
        }
    }
    
    func showWelcomeName(){
        let alert = UIAlertController(title: "Welcome", message: "You log in as \(self.userName)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.entities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntityCell", for: indexPath) as! EntityCell
        
        let currentEntity = self.entities[indexPath.row]
        cell.name.text = currentEntity.name
        cell.imageEntity.image = UIImage(named: currentEntity.images![1])
        if Bool(self.loggedInEntity?.connections?.contains(currentEntity.name ?? "") ?? false){
            cell.isConnected.text = "Connected"
        }
        else{
            cell.isConnected.text = "Not-Connected"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let entityDetailsVC = storyboard.instantiateViewController(identifier: "EntityDetails") as! EntityDetailsViewController
        entityDetailsVC.entity = self.entities[indexPath.row]
        self.navigationController?.pushViewController(entityDetailsVC, animated: true)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "loggedInEntity")
        UserDefaults.standard.set(false, forKey: "rememberMe")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(identifier: "Login") as! LoginViewController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)    }
    
    @IBAction func ttgPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "donationModeIsOn")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let connectionsVC = storyboard.instantiateViewController(identifier: "Connections") as! ConnectionsTableViewController
        self.navigationController?.pushViewController(connectionsVC, animated: true)
    }

}
