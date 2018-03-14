//
//  ViewController.swift
//  parkidle
//
//  Created by Simone Staffa on 12/03/18.
//  Copyright © 2018 Parkidle. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    //MARK: Properties
    
    
    @IBOutlet var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
    
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        signInButton.colorScheme = GIDSignInButtonColorScheme.light
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    
    @IBAction func updateUI(_ sender: UIButton) {
        let secondViewController = MapViewController(nibName: nil, bundle: nil)
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
}

