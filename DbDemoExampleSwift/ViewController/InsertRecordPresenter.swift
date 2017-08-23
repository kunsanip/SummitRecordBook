//
//  InsertRecordPresenter.swift
//  Customer Record Summit
//
//  Created by Admin on 8/23/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation
//
//  InsertRecordPresenter.swift
//  Customer Record Summit
//
//  Created by Admin on 8/23/17.
//  Copyright © 2017 Summit. All rights reserved.
//


class InsertRecordPresenter{
    
    var modelManager: ModelManager = ModelManager()
    
    //MARK: LYNDA for MVP tranform
    var validation: Validation! = Validation()
    
    
    //MARK: LYNDA for MVP transform
    var emailHandling: Email! = Email()
    
    
    
    func emailValidation(emailAddress: String) -> Bool{
        let valid = validation.isValidEmail(emailAddress)
        return valid
    }
    
    func phoneValidation(phoneNumber: String) -> Bool{
        let valid = validation.validatePhone(phoneNumber)
        return valid
    }
    
    func updateRecord(customerInfo: CustomerInfo) -> Bool{
        let updateStatus:Bool = modelManager.getInstance().updateStudentData(customerInfo)
        
        return updateStatus
    }
    
    func sendCustomerEmail(name: String, emailAddress: String, companyName: String, companyAddress: String, companyPassword: String, companyHost: String, companyPortNumber: Int){
        
        emailHandling.MailCoreUser(name: name, emailAddress: emailAddress, companyName: companyName, companyAddress: companyAddress, companyPassword: companyPassword, companyHost: companyHost, companyPortNumber: companyPortNumber)
        
    }
    
    func sendCompanyEmail(name: String, emailAddress: String, companyName: String, companyAddress: String, companyPassword: String, companyHost: String, companyPortNumber: Int){
        
        
        emailHandling.MailCoreUser(name: name, emailAddress: emailAddress, companyName: companyName, companyAddress: companyAddress, companyPassword: companyPassword, companyHost: companyHost, companyPortNumber: companyPortNumber)
    }
    
    
}
