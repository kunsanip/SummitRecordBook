//
//  FTPClient.swift
//  Customer Record Summit
//
//  Created by Admin on 9/5/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation
import RebekkaTouch


class FTPClient{
    
    var session: Session!
    
    var jsonString:String = String()

    
    //MARK: Initialization of the FTP Client
    
     init(){
        // Override point for customization after application launch.
        
        var configuration = SessionConfiguration()
        configuration.host = "ftp://sanip.com.au/public_html"
        configuration.username = "kunsanip"
        configuration.password = "Blink182"
        configuration.encoding = String.Encoding.utf8
        self.session = Session(configuration: configuration)
        
        testList()
        //testDownload()
        //testCreate()
    }
    
    
    //MARK: FTP Upload

    func testUpload(jsonString: String) {

        print("Always be careful on strings => \(jsonString)")
        let documentsURL = Bundle.main.resourceURL
  
        do{
            
            try jsonString.write(to: documentsURL!.appendingPathComponent("JsonCustomerRecord12.json"), atomically: true, encoding: String.Encoding.utf8)
        }
        catch let error as NSError{
            print("Failure to write to Path")
            print(error)
        }
        
        
        
        let fromPath = documentsURL!.appendingPathComponent("JsonCustomerRecord12.json")
        
        
        
        print("Here it goes \(fromPath)")
        let path = "//customerRecord.json"
        
        
        
        self.session.upload(fromPath, path: path) {
            (result, error) -> Void in
            print("Upload file with result:\n\(result), error: \(error)\n\n")
            
        }
    }
    
    
    
    
    //MARK: FTP Download
    func testDownload() {
        self.session.download("/1MB.zip") {
            (fileURL, error) -> Void in
            print("Download file with result:\n\(fileURL), error: \(error)\n\n")
            if let fileURL = fileURL {
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch let error as NSError {
                    print("Error: \(error)")
                }
                
            }
        }
    }
    
    
    //MARK: CREATING DIRECTORY
    func testCreate() {
        let name = UUID().uuidString
        self.session.createDirectory("/upload/\(name)") {
            (result, error) -> Void in
            print("Create directory with result:\n\(result), error: \(error)")
        }
    }
    //MARK: FTP Listing Directory
    func testList() {
        self.session.list("/") {
            (resources, error) -> Void in
            print("List directory with result:\n\(String(describing: resources)), error: \(String(describing: error))\n\n")
        }
    }
    
    
    
    
}
