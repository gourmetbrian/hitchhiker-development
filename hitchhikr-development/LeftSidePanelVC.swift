//
//  LeftSidePanelVC.swift
//  hitchhikr-development
//
//  Created by Brian Lane on 7/11/17.
//  Copyright © 2017 Brian Lane. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {

    @IBOutlet weak var userAccountTypeLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var loginOutBtn: UIButton!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickUpModeLabel: UILabel!
    
    let appDelegate = AppDelegate.getAppDelegate()
    
    var currentUserID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        observePassengersAndDrivers()
        
        if FIRAuth.auth()?.currentUser == nil {
            userEmailLabel.text = ""
            userAccountTypeLabel.text = ""
            userImageView.isHidden = true
            loginOutBtn.setTitle("Sign Up / Login", for: .normal)
            pickupModeSwitch.isOn = false
            pickupModeSwitch.isHidden = true
            pickUpModeLabel.isHidden = true
        } else {
            userEmailLabel.text = FIRAuth.auth()?.currentUser?.email
            userAccountTypeLabel.text = ""
            userImageView.isHidden = false
            pickupModeSwitch.isHidden = false
            pickUpModeLabel.isHidden = false
            loginOutBtn.setTitle("Logout", for: .normal)
        }
    }
    
    func observePassengersAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if snap.key == FIRAuth.auth()?.currentUser?.uid {
                        self.userAccountTypeLabel.text = "PASSENGER"
                        self.currentUserID = snap.key
                    }
                }
            }
        })
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if snap.key == FIRAuth.auth()?.currentUser?.uid {
                        self.userAccountTypeLabel.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickUpModeLabel.isHidden = false
                        self.currentUserID = snap.key
                    }
                }
            }
        })
    }


    @IBAction func signUpBtnPressed(_ sender: Any) {
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            if let login = loginVC {
                present(login, animated: true, completion: nil)
            } else {
                print("Sorry, there was an error.")
            }
        } else {
            do {
                try FIRAuth.auth()?.signOut()
                currentUserID = nil
                if FIRAuth.auth()?.currentUser == nil {
                    print("********* there is no current user")
                } else {
                    print("**********Somehow there is still a user, it is \(String(describing: currentUserID))")
                }
                userEmailLabel.text = ""
                userAccountTypeLabel.text = ""
                userImageView.isHidden = true
                pickupModeSwitch.isHidden = true
                pickUpModeLabel.text = ""
                loginOutBtn.setTitle("Sign Up / Login", for: .normal)
            } catch (let error) {
                print(error)
            }
        }
    }

    @IBAction func switchToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickUpModeLabel.text = "PICKUP ENABLED"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserID!).updateChildValues(["isPickupModeEnabled": true])
        } else {
            pickUpModeLabel.text = "PICKUP ENABLED"
            appDelegate.MenuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserID!).updateChildValues(["isPickupModeEnabled": false])
        }
    }
}
