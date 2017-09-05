//
//  Email.swift
//  Customer Record Summit
//
//  Created by Admin on 8/23/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation


class SMTP{


    


}

extension SMTP{
    
    // This one is used at the moment: 2nd app submission
    public func MailCore( name: String, emailAddress:String){
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "sanipcr7@gmail.com"
        smtpSession.password = "Cristiano7"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        var sanip: String  = String()
        sanip = emailAddress
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: name, mailbox: sanip)]
        
        builder.header.from = MCOAddress(displayName: "Sanip Shrestha", mailbox: "brothers@gmail.com")
        builder.header.subject = ""
        builder.htmlBody = "Hi \(name), <br>Thank you for visiting us! <br>You have been successfully registered in our Record Book."
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
    
    //Ideal scenario for sending company email
    public func MailCoreCompany( name: String, emailAddress:String, companyName:String, companyEmailAddress:String, companyPassword: String, companyHost: String, companyPortNumber: Int){
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = companyHost
        smtpSession.username = companyEmailAddress
        smtpSession.password = companyPassword
        smtpSession.port = UInt32(companyPortNumber)
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        var userEmail: String = String()
        userEmail = emailAddress
        
        var companyAddress: String  = String()
        companyAddress = companyEmailAddress
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Summit Record Book", mailbox: companyAddress)]
        builder.header.from = MCOAddress(displayName: "Summit Record Book", mailbox: "Headquarter")
        builder.header.subject = "New customer has been recorded in Summit Record Book."
        builder.htmlBody = "<br><h3>Customer Detail</h3><p>Name: \(name) </p><p>Email: \(userEmail)"
        
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
    
    //This method is necessary for ideal scenario when sending email
    public func MailCoreUser( name: String, emailAddress:String, companyName: String, companyAddress: String, companyPassword: String, companyHost: String, companyPortNumber: Int){
        
        print(companyHost)
        print(companyName)
        print(companyAddress)
        print(companyPassword)
        print(companyPortNumber)
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = companyHost
        smtpSession.username = companyAddress
        smtpSession.password = companyPassword
        smtpSession.port = UInt32(companyPortNumber)
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        var sanip: String  = String()
        sanip = emailAddress
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: name, mailbox: sanip)]
        
        builder.header.from = MCOAddress(displayName: companyName, mailbox: "noreply")
        builder.header.subject = "Thank you for visiting us."
        builder.htmlBody = "Hi \(name), <br><br>You have been successfully registered in our Record Book.<br><br>Thank you for visiting us! <br><br>Kind regards,<br>\(companyName)"
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
    
    

}
