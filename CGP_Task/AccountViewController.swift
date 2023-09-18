//
//  AccountViewController.swift
//  CGP_Task
//
//  Created by Dmytro Lyshtva on 12.09.2023.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class AccountViewController: UIViewController {
    
    let signInButton = GIDSignInButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupGoogle()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        signInButton.center = self.view.center
    }
    
    private func setupGoogle() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
                
        GIDSignIn.sharedInstance.configuration = config
        }
        
       @objc func googleTapped() {
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                guard error == nil else {
                    self.view.backgroundColor = .red
                    print("Auth not Success")
                    return
                    
                }
                print("Auth Success")
                self.view.backgroundColor = .green
            }
        }
    }

