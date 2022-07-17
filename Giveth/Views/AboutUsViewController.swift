//
//  AboutUsViewController.swift
//  Giveth
//
//  Created by Jack on 23/06/22.
//

import Foundation
import UIKit

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
    }
    
    @IBAction func openFb(_ sender: Any) {
        guard let url = URL(string: "https://facebook.com") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func openInsta(_ sender: Any) {
        guard let url = URL(string: "https://instagram.com") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func openSnapChat(_ sender: Any) {
        guard let url = URL(string: "https://snapchat.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func contactUs(_ sender: Any) {
        let phoneNumber = "111-222-3333"
        let numberUrl = URL(string: "tel://\(phoneNumber)")!
        if UIApplication.shared.canOpenURL(numberUrl) {
            UIApplication.shared.open(numberUrl)
        }
    }
    
}
