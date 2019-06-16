//
//  InsertRecordPresenter.swift
//  Customer Record Summit
//
//  Created by Sanip Shrestha on 8/23/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation
//
//  InsertRecordPresenter.swift
//  Customer Record Summit
//
//  Created by Sanip Shrestha on 8/23/17.
//  Copyright © 2017 Summit. All rights reserved.
//


class InsertRecordPresenter{
    
    var modelManager: ModelManager = ModelManager()
    
    //MARK: LYNDA for MVP tranform
    var validation: Validation! = Validation()
    var emailHandling: Email! = Email()
    
    func emailValidation(emailAddress: String) -> Bool{
        let valid = validation.isValidEmail(email: emailAddress)
        return valid
    }
    
    func phoneValidation(phoneNumber: String) -> Bool{
        let valid = validation.validatePhone(phoneNumber)
        return valid
    }
    
    func insertRecord(customerInfo: CustomerInfo) -> Bool{
        let insertStatus:Bool = modelManager.getInstance().addStudentData(customerInfo)
        return insertStatus
    
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
    
    
    func getPickerItem() -> [String]{
    
        var newPicker: PickerInfo = PickerInfo()
        
        return newPicker.getPickerArray()
    
    }
    
}
