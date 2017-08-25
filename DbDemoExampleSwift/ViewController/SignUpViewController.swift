//
//  SignUpViewController.swift
//  DbDemoExampleSwift
//
//  Created by Admin on 28/09/2016.
//  Copyright © 2016 Summit. All rights reserved.
//

import UIKit



class SignUpViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: TEXTFIELDS
    
    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtUsername: UITextField!
    
    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtPassword: UITextField!
 
    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtReEnteredPassword: UITextField!
 
    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtCompanyName: UITextField!

    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtEmailPassword: UITextField!

    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtEmailHost: UITextField!
    
    //TEXTFIELD: USERNAME
    @IBOutlet weak var txtPortNumber: UITextField!
    
    
    //OBJECT: SIGNUPPRESENTER
    fileprivate var presenter: SignUpPresenter!
    
    
    //INITIALIZER: VIEWDIDLOAD METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtUsername.delegate = self;
        self.txtPassword.delegate = self;
        self.txtEmailAddress.delegate = self;
        self.txtCompanyName.delegate = self;
        self.txtReEnteredPassword.delegate = self;
        self.txtEmailHost.delegate = self;
       self.txtPortNumber.delegate = self;
        presenter = SignUpPresenter()
        // Do any additional setup after loading the view.
    }
    
    //METHOD: STATUS BAR HIDDEN
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //METHOD: BUTTON SIGNUP - WHEN USER SIGNS UP TO CREATE NEW ACCOUNT
    @IBAction func btnSignUp(_ sender: AnyObject) {
       
        let emailVal:Bool = presenter.emailValidation(emailAddress: txtEmailAddress.text!)
        let companyInfo: CompanyInfo = CompanyInfo()
        
        companyInfo.Username = txtUsername.text!
        companyInfo.Password = txtPassword.text!
        companyInfo.CompanyName = txtCompanyName.text!
        companyInfo.CompanyEmailAddress = txtEmailAddress.text!
        companyInfo.CompanyEmailPassword = txtEmailPassword.text!
        companyInfo.EmailHost = txtEmailHost.text!
        companyInfo.PortNumber = Int(txtPortNumber.text!)!
        
        
        if(txtUsername.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter username.", delegate: nil)
        }
        
      
        else if(txtPassword.text == ""){
            Util.invokeAlertMethod("", strBody: "Please enter password.", delegate: nil)
        }
        
        else if(txtReEnteredPassword.text != txtPassword.text){
            Util.invokeAlertMethod("", strBody: "Your password doesn't match with above password. Please enter the same password.", delegate: nil)
        }
        else if(txtCompanyName.text == ""){
            Util.invokeAlertMethod("", strBody: "Please enter a company name.", delegate: nil)
        }
       
     
        else if (presenter.checkUsername(companyInfo: companyInfo) == false){
            Util.invokeAlertMethod("", strBody: "This username has already been taken. Please enter different username.", delegate: nil)

            
        }
        else if(emailVal == false)
        {
            Util.invokeAlertMethod("", strBody: "Invalid email address.", delegate: nil)
        }
            
        else if(txtEmailPassword.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter Email Password.", delegate: nil)
        }
    
        else if(txtEmailHost.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter Email Host Address.", delegate: nil)
        }
            
            
        else if(txtPortNumber.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter Port Number.", delegate: nil)
        }
            
            
        else{
     
        let isInserted = presenter.addCompanyData(companyInfo: companyInfo)
        if isInserted {
            Util.invokeAlertMethod("", strBody: "Your account has been successfully created.", delegate: nil)
            self.performSegue(withIdentifier: "SignIn", sender: sender)

            
        } else {
            Util.invokeAlertMethod("", strBody: "Error in creating account.", delegate: nil)
            }}
        


    }
 
 
    //SEGUE: I HAVE AN ACCOUNT - FORWARDS TO THE HOME SCREEN
    @IBAction func btnIHaveAccount(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SignIn", sender: sender)

    }
    
   
    
    
    //VIEW: TEXTFIELDSHOULDRETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
  }
