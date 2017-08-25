//
//  SignUpPresenter.swift
//  Customer Record Summit
//
//  Created by Admin on 8/23/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation


class SignUpPresenter{
    var modelManager: ModelManager = ModelManager()
    
    var validation: Validation! = Validation()
    
    
    func addCompanyData(companyInfo: CompanyInfo) -> Bool{
        let companyDataStatus:Bool = modelManager.getInstance().addCompanyData(companyInfo)
        return companyDataStatus
    }
    
    func emailValidation(emailAddress: String) -> Bool{
        
        let valid = validation.isValidEmail(email: emailAddress)
    
        return valid
    }
    
    func checkUsername(companyInfo: CompanyInfo) -> Bool{
    
      let userexist = modelManager.getInstance().checkUsername(companyInfo)
        
        return userexist
    }
}
