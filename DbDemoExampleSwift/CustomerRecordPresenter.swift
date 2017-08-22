//
//  CustomerRecordPresenter.swift
//  Customer Record Summit
//
//  Created by Admin on 8/22/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation


class CustomerRecordPresenter {

    
    var marrStudentData : NSMutableArray!

    func getStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getAllStudentData()
        
        
    }
   
}
