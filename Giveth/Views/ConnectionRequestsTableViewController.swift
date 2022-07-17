//
//  ConnectionRequestsTableViewController.swift
//  Giveth
//
//  Created by Jagsifat Makkar on 2022-01-23.
//

import UIKit

class ConnectionRequestsTableViewController: UITableViewController {
    
    var loggedInEntity : Entity? = nil
    private let coreDBHelper = CoreDBHelper.getInstance()
    var postsList = [UploadData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 125
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loggedInEntity = self.coreDBHelper.getEntityByName(UserDefaults.standard.string(forKey: "loggedInEntity") ?? "")
        tableView.delegate = self
        tableView.dataSource = self
        self.fetchAllPosts()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.postsList.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //delete the task
        if (editingStyle == UITableViewCell.EditingStyle.delete && indexPath.row < self.postsList.count){
            //ask for the user confirmation
//            self.deleteRequestFromList(indexPath: indexPath)
        }
    }
    
    /*private func deleteRequestFromList(indexPath : IndexPath){
        self.coreDBHelper.deleteConnectionRequest(self.postsList[indexPath.row].name ?? "", self.loggedInEntity?.name ?? "")
        self.fetchAllConnectionRequests()
    }*/

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionRequestCell", for: indexPath) as! ConnectionRequestCell
        
        cell.nameLabel.text = self.postsList[indexPath.row].name
        if let url = URL(string: self.postsList[indexPath.row].image1 ?? "") {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.entityImage.image = UIImage(data: data ?? Data())
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*let alert = UIAlertController(title: "Connection Request", message: "How would you like to proceed?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "View Profile", style: .default, handler: { UIAlertAction in
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let entityDetailsVC = storyboard.instantiateViewController(identifier: "EntityDetails") as! EntityDetailsViewController
            entityDetailsVC.entity = self.postsList[indexPath.row]
            self.navigationController?.pushViewController(entityDetailsVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Accept Request", style: .default, handler: { UIAlertAction in
            self.coreDBHelper.updateEntitiesConnections(self.postsList[indexPath.row].name ?? "", self.loggedInEntity?.name ?? "")
            self.deleteRequestFromList(indexPath: indexPath)
        }))
        alert.addAction(UIAlertAction(title: "Decline Request", style: .default, handler: { UIAlertAction in
            self.deleteRequestFromList(indexPath: indexPath)
        }))
        self.present(alert, animated: true, completion: nil)*/
    }
    
    private func fetchAllPosts(){
        self.postsList.removeAll()
        FirebaseService.loadPosts { posts in
            self.postsList = posts
            self.tableView.reloadData()
        }
    }
}
