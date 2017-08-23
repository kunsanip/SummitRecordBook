//
//  LogInPresenter.swift
//  Customer Record Summit
//
//  Created by Admin on 8/23/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation
class LogInPresenter{
    
    var marrCredential : NSMutableArray!
    var modelManager: ModelManager = ModelManager()
    
    func getProfile(username: String, password: String) -> NSMutableArray{
        marrCredential = NSMutableArray()
        marrCredential = modelManager.getInstance().getCredential(username, txtpassword: password)
        return marrCredential
    }
}
