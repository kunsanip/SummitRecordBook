//
//  SignUpViewController.swift
//  DbDemoExampleSwift
//
//  Created by Admin on 28/09/2016.
//  Copyright © 2016 Summit. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtUsername: UITextField!
       
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
 
    @IBOutlet weak var txtReEnteredPassword: UITextField!
 
    @IBOutlet weak var txtCompanyName: UITextField!

    @IBOutlet weak var txtEmailPassword: UITextField!

    @IBOutlet weak var txtEmailHost: UITextField!
    
    @IBOutlet weak var txtPortNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtUsername.delegate = self;
        self.txtPassword.delegate = self;
        self.txtEmailAddress.delegate = self;
        self.txtCompanyName.delegate = self;
        self.txtReEnteredPassword.delegate = self;
//        self.txtEmailHost.delegate = self;
//        self.txtPortNumber.delegate = self;
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnSignUp(_ sender: AnyObject) {
       
        let emailVal:Bool = isValidEmail(txtEmailAddress.text!)

        let companyInfo: CompanyInfo = CompanyInfo()
        
        
        companyInfo.Username = txtUsername.text!
        companyInfo.Password = txtPassword.text!
        companyInfo.CompanyName = txtCompanyName.text!
        companyInfo.CompanyEmailAddress = txtEmailAddress.text!
        companyInfo.CompanyEmailPassword = txtEmailPassword.text!
        companyInfo.EmailHost = txtEmailHost.text!
        companyInfo.PortNumber = Int(txtPortNumber.text!)!
        
        
        
        print(ModelManager.getInstance().checkUsername(companyInfo))
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
       
     
        else if (ModelManager.getInstance().checkUsername(companyInfo) == false){
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
     
        let isInserted = ModelManager.getInstance().addCompanyData(companyInfo)
        if isInserted {
            Util.invokeAlertMethod("", strBody: "Your account has been successfully created.", delegate: nil)
            self.performSegue(withIdentifier: "SignIn", sender: sender)

            
        } else {
            Util.invokeAlertMethod("", strBody: "Error in creating account.", delegate: nil)
            }}
        


    }
    func isValidEmail(_ email:String!) -> Bool{
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
   
    @IBAction func btnIHaveAccount(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SignIn", sender: sender)

    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

  }