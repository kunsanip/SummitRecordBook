//
//  LogInViewController.swift
//  DbDemoExampleSwift
//
//  Created by Admin on 27/09/2016.
//  Copyright © 2016 Summit. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
  
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    var marrCredential : NSMutableArray!

     
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

        
        print(txtUsername.text!)
        print(txtPassword.text!)

        
        
      marrCredential = NSMutableArray()
      marrCredential = ModelManager.getInstance().getCredential(txtUsername.text!, txtpassword: txtPassword.text!)
        
        
        print(marrCredential.count)
        
        
            
            
        
        if (marrCredential.count == 1){
            self.performSegue(withIdentifier: "loginsegue", sender: sender)

        }
        else{
            Util.invokeAlertMethod("Incorrect Username/Password", strBody: "Please try again", delegate: nil)


        }
        
        
        

    }
  
    
    override func viewDidLoad() {
        
        self.txtUsername.delegate = self
        self.txtPassword.delegate = self
        super.viewDidLoad()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSignUp(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "SignUpSegue", sender: sender)

    }
    //MARK: UIButton Action methods
    
    @IBAction func btnBackClicked(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func MailCore(){
       
            
            var smtpSession = MCOSMTPSession()
            smtpSession.hostname = "smtp.live.com"
            smtpSession.username = "sanip_7@live.com"
            smtpSession.password = "Cristiano7"
            smtpSession.port = 587
            //        smtpSession.authType = MCOAuthType.saslPlain
            smtpSession.connectionType = MCOConnectionType.TLS
            smtpSession.connectionLogger = {(connectionID, type, data) in
                if data != nil {
                    if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                        NSLog("Connectionlogger: \(string)")
                    }
                }
            }
            
            var builder = MCOMessageBuilder()
            builder.header.to = [MCOAddress(displayName: "Rool", mailbox: "sanip_7@live.com")]
            builder.header.from = MCOAddress(displayName: "Matt R", mailbox: "sanipcr7@gmail.com")
            builder.header.subject = "My message"
            builder.htmlBody = "Yo Rool, this is a test message!"
            
            let rfc822Data = builder.data()
            let sendOperation = smtpSession.sendOperation(with: rfc822Data)
            sendOperation?.start { (error) -> Void in
                if (error != nil) {
                    NSLog("Error sending email: \(error)")
                } else {
                    NSLog("Successfully sent email!")
                }
            }

        }}
   





