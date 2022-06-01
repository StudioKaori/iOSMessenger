//
//  ViewController.swift
//  Messenger
//
//  Created by Kaori Persson on 2022-05-31.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    // check if the user is logged in or not
    override func viewDidAppear(_ animated: Bool) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            // Show the nav fullscreen instead of model to avoid being dismissed by the user
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

