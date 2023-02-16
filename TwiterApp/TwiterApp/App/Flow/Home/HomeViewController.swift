//
//  HomeViewController.swift
//  TwiterApp
//
//  Created by Bani Chan on 2023/2/15.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let handle = Auth.auth().addStateDidChangeListener { auth, user in
          print("\(auth) \(user)")
        }
    }


}
