//
//  LogInViewController.swift
//  DbDemoExampleSwift
//
//  Created by Sanip Shrestha on 27/09/2016.
//  Copyright © 2016 Summit. All rights reserved.
//

import UIKit



class LogInViewController: UIViewController, UITextFieldDelegate {
  
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    var presenter:LogInPresenter = LogInPresenter()
    
    override func viewDidLoad()
    {
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    @IBAction func btnSignUp(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "SignUpSegue", sender: sender)
    }

    @IBAction func AboutSummit(_ sender: Any) {
        self.performSegue(withIdentifier: "aboutsegue", sender: sender)

    }
    
    @IBAction func btnLogIn(_ sender: AnyObject) {

        if(txtUsername.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter username.", delegate: nil)
        }
        else if(txtPassword.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter password.", delegate: nil)
        }
      
        let loginstatus:NSMutableArray! = presenter.getProfile(username: txtUsername.text!, password: txtPassword.text!)
        
        //checking if there is entity in loginstatus
        if (loginstatus.count == 1)
        {
            self.performSegue(withIdentifier: "loginsegue", sender: sender)
        }
        else
        {
            Util.invokeAlertMethod("Incorrect Username/Password", strBody: "Please try again", delegate: nil)
        }
    }
    
    @IBAction func LogIn(_ sender: Any) {
        
        if(txtUsername.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter username.", delegate: nil)
        }
        else if(txtPassword.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter password.", delegate: nil)
        }
        
        let loginstatus:NSMutableArray! = presenter.getProfile(username: txtUsername.text!, password: txtPassword.text!)
        
        //checking if there is entity in loginstatus
        if (loginstatus.count == 1)
        {
            self.performSegue(withIdentifier: "newLogIn", sender: sender)
        }
        else
        {
            Util.invokeAlertMethod("Incorrect Username/Password", strBody: "Please try again", delegate: nil)
        }
    }
    
    //MARK: UIButton Action methods
    @IBAction func btnBackClicked(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
   }
   





