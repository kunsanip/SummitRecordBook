//
//  JsonConverter.swift
//  Customer Record Summit
//
//  Created by Sanip Shrestha on 9/5/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation
import RebekkaTouch
class JsonConverter{
    
    
    static var jsonString: String = String()
    var session: Session!

    
    class func jsonConverter(customerInfoArray: [CustomerInfo]){
        jsonString = ""
       jsonString.append("[")
        for customerItem in customerInfoArray{
            
            
            
            jsonString.append("{\"FirstName\":\"\(customerItem.FirstName)\", \"LastName\":\"\(customerItem.LastName)\", \"EmailAddress\":\"\(customerItem.EmailAddress)\", \"PhoneNumber\":\"\(customerItem.PhoneNumber)\", \"ReasonVisit\":\"\(customerItem.ReasonVisit)\", \"TimeStamp\":\"\(customerItem.TimeStamp)\"},")
            
            
        }
       
        jsonString.removeLast()
       jsonString.append("]")
        
        
    }
    
    class func jsonFileCreator(jsonString: String){
        do{
            
            //Write to the file
            try jsonString.write(toFile: Util.getPath("JsonCustomerRecord.json"), atomically: true, encoding: String.Encoding.utf8)
            
        }
        catch let error as NSError{
            print("Failer to write to Path")
            print(error)
        }
        
    }
    
    
    class func jsonSender(){
        var ftpClient: FTPClient = FTPClient()
        ftpClient.testUpload(jsonString: jsonString)
        
    }
    
    
    
}
