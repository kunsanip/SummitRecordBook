//
//  PickerInfo.swift
//  Customer Record Summit
//
//  Created by Admin on 8/25/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation


class PickerInfo{

    var pickerArray:[String] = ["Skilled Migration Visa","Parent Visa", "Partner Visa","Employer Sponsership","Visa Appeals","Temporary Skill Shortage(TSS) Visa","Tax Return"]
    
    
    func getPickerArray() -> [String]{
    
        return pickerArray
    
    }
    
    func setPickerArray(pickerArray: [String]){
     
         self.pickerArray = pickerArray
    
    
    }
    
    func addInPickerArray(newPickerItem: String){
    
        self.pickerArray.append(newPickerItem)
    }

}
