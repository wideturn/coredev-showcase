//
//  ViewController.swift
//  coreDev-Showcase
//
//  Created by Samuel Atwell on 11/15/15.
//  Copyright © 2015 CoreDev. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordFieled : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }


    @IBAction func fbBtnPressed(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                print("Facebook Login Failed! Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("successful FB Login \(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    
                    if error != nil {
                        print("Login Failed")
                    } else {
                        print("Logged In! \(authData)")
                        
                        let user = ["provider": authData.provider!]
                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                    
                })
            }
        }
    
    }
    
    @IBAction func attemptLogin(sende: UIButton!) {
        
        if let email = emailField.text where email != "", let pwd = passwordFieled.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: {
                error, authData in
            
                if error != nil {
                    print(error)
                    
                    if error.code == STATUS_ACCOUNT_NONEXIST {
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Problem creating account. Try Something else")
                            } else {
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { err, authData in
                                    
                                    let user = ["Provider": authData.provider!]
                                    DataService.ds.createFirebaseUser(authData.uid, user: user)
                                    
                                })
                                
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                            }
                        })
                    } else {
                        self.showErrorAlert("Could not Login", msg: "Please check username or password")
                    }
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
                
            })
                
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and password")
        }
        
    }
    
    func showErrorAlert(tile: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle:  .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
