

import UIKit
import CoreData
let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    var username: String = String()
    var companyName: String = String()
    var companyAddress: String = String()
    var companyEmailPassword: String = String()
    var emailHost: String = String()
    var portNumber: Int = 0
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("customerDB.sqlite"))
        }
        return sharedInstance
    }
    
    func setUserName(_ txtusername:String){
        self.username = txtusername
    
    
    }
    
    
    func setCompanyDetail(_ credential: Credential){
        self.companyName = credential.CompanyName
        self.companyAddress = credential.CompanyEmail
        self.companyEmailPassword = credential.CompanyEmailPassword
        self.emailHost = credential.emailHost
        self.portNumber = credential.portNumber
        
        
        }
    
    
    func addStudentData(_ customerInfo: CustomerInfo) -> Bool {
        sharedInstance.database!.open()
        
        print(customerInfo.FirstName)
        print(customerInfo.LastName)
        print(customerInfo.EmailAddress)
        print(customerInfo.PhoneNumber)
        print(customerInfo.VisitNumber)
        print(customerInfo.ReasonVisit)
        print(customerInfo.TimeStamp)
        
      

        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO \(self.username) (firstName, lastName, emailAddress, phoneNumber, visitReason, timeStamp) VALUES (?, ?,?,?,?,?)", withArgumentsIn: [customerInfo.FirstName, customerInfo.LastName, customerInfo.EmailAddress, customerInfo.PhoneNumber,customerInfo.ReasonVisit, customerInfo.TimeStamp])
      
    
        sharedInstance.database!.close()
        return isInserted
    }

    
    func addCompanyData(_ companyInfo: CompanyInfo) -> Bool {
        sharedInstance.database!.open()
        
//        print(companyInfo.Username)
//        print(companyInfo.Password)
//        print(companyInfo.CompanyName)
//        print(companyInfo.CompanyEmailAddress)
//        print(companyInfo.CompanyEmailPassword)
//        print(companyInfo.EmailHost)
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO companyDetails (username, password, companyName, companyEmailAddress, companyEmailPassword, emailHost, portNumber) VALUES (?, ?,?,?,?,?,?)", withArgumentsIn: [companyInfo.Username, companyInfo.Password, companyInfo.CompanyName, companyInfo.CompanyEmailAddress, companyInfo.CompanyEmailPassword, companyInfo.EmailHost, companyInfo.PortNumber])
        print (isInserted)
        sharedInstance.database!.executeUpdate("CREATE TABLE '\(companyInfo.Username)' ( `visitNumber` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, `firstName` TEXT, `lastName` TEXT, `emailAddress` TEXT, `phoneNumber` TEXT, `visitReason` TEXT, `timeStamp` TEXT )", withArgumentsIn: nil)
        
        sharedInstance.database!.close()
        return isInserted
    
    
    
    }
    
    func checkUsername(_ companyInfo: CompanyInfo) -> Bool {
        sharedInstance.database!.open()
        var checkstatus: Bool = true
        
//        print(companyInfo.Username)
//        print(companyInfo.Password)
//        print(companyInfo.CompanyName)
//        print(companyInfo.CompanyEmailAddress)
        
        
        //Query the company details if username is found there will be result set hence check status will be false
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM companyDetails WHERE username LIKE '\(companyInfo.Username)'", withArgumentsIn: nil)
        
        
        if (resultSet != nil) {
            while resultSet.next() {
                
                
                checkstatus = false
            }
        
        }
        return checkstatus
    }
    
    
    func updateStudentData(_ customerInfo: CustomerInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE \(self.username) SET firstName=?, lastName=?, emailAddress= ?, phoneNumber = ?, visitReason = ?, timeStamp = ?  WHERE visitnumber=?", withArgumentsIn: [customerInfo.FirstName, customerInfo.LastName, customerInfo.EmailAddress, customerInfo.PhoneNumber, customerInfo.ReasonVisit,customerInfo.TimeStamp, customerInfo.VisitNumber])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteStudentData(_ customerInfo: CustomerInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM \(self.username) WHERE visitnumber=?", withArgumentsIn: [customerInfo.VisitNumber])
        sharedInstance.database!.close()
        return isDeleted
    }

    func getAllStudentData() -> NSMutableArray {
        sharedInstance.database!.open()
        
        //Query
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username)", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                
                
            //    customerInfo.RollNo = resultSet.stringForColumn("RollNo")
              //  customerInfo.Name = resultSet.stringForColumn("Name")
                //customerInfo.Marks = resultSet.stringForColumn("Marks")
               //customerInfo.EmailAddress = resultSet.stringForColumn("EmailAddress")
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    func getAllCustomerData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username)", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                
                
                //    customerInfo.RollNo = resultSet.stringForColumn("RollNo")
                //  customerInfo.Name = resultSet.stringForColumn("Name")
                //customerInfo.Marks = resultSet.stringForColumn("Marks")
                //customerInfo.EmailAddress = resultSet.stringForColumn("EmailAddress")
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    
    
    func getSortedByFirstName() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username) ORDER BY firstName", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
        
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    func getSortedByLastName() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username) ORDER BY lastName", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    func getSortedByEmailAddress() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username) ORDER BY emailAddress", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    func getSortedByPhoneNumber() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username) ORDER BY phoneNumber", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    func getSortedByVisitReason() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username) ORDER BY visitReason", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    func getSortedByVisitedOn() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM \(self.username) ORDER BY timeStamp", withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    func getSearchResultbyFirstName(_ searchterm:String) -> NSMutableArray {
        let searchquery:String = "SELECT * FROM \(self.username) WHERE firstName LIKE '\(searchterm)' UNION SELECT * FROM \(self.username) WHERE lastName LIKE '\(searchterm)' UNION SELECT * FROM \(self.username) WHERE emailAddress LIKE '\(searchterm)' UNION SELECT * FROM \(self.username) WHERE phoneNumber LIKE '\(searchterm)' UNION SELECT * FROM \(self.username) WHERE visitReason LIKE '\(searchterm)'UNION SELECT * FROM \(self.username) WHERE timeStamp LIKE '\(searchterm)'UNION SELECT * FROM \(self.username) WHERE visitNumber LIKE '\(searchterm)'"
        
        print(searchquery)

        sharedInstance.database!.open()
  
     
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(searchquery, withArgumentsIn: nil)
        let marrcustomerInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let customerInfo : CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = resultSet.string(forColumn: "visitnumber")
                customerInfo.FirstName = resultSet.string(forColumn: "firstName")
                customerInfo.LastName  = resultSet.string(forColumn: "lastName")
                customerInfo.EmailAddress = resultSet.string(forColumn: "emailAddress")
                customerInfo.PhoneNumber = resultSet.string(forColumn: "phoneNumber")
                customerInfo.ReasonVisit = resultSet.string(forColumn: "visitReason")
                customerInfo.TimeStamp = resultSet.string(forColumn: "timeStamp")
                
                
                marrcustomerInfo.add(customerInfo)
            }
        }
        sharedInstance.database!.close()
        return marrcustomerInfo
    }
    
    func getCredential(_ txtusername:String, txtpassword:String) -> NSMutableArray {
        sharedInstance.database!.open()
       
        // Authenticating username and password
        let loginsearchquery  = "SELECT * FROM companyDetails WHERE username = '\(txtusername)' AND password = '\(txtpassword)'"
        
        // Executing above query
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery(loginsearchquery, withArgumentsIn: nil)
        
        // Creating NS Mutable Array
        let marrCredential : NSMutableArray = NSMutableArray()
        
        
        
        if (resultSet != nil) {
            while resultSet.next() {
                 setUserName(txtusername)   //setting username within the class
                
                let credential_detail : Credential = Credential()
                credential_detail.UserName = resultSet.string(forColumn: "username")
                credential_detail.Password = resultSet.string(forColumn: "password")
                credential_detail.CompanyName = resultSet.string(forColumn: "companyName")
                
                credential_detail.CompanyEmail = resultSet.string(forColumn: "CompanyEmailAddress")
                credential_detail.CompanyEmailPassword = resultSet.string(forColumn: "CompanyEmailPassword")
                
                credential_detail.emailHost = resultSet.string(forColumn: "emailHost")
                credential_detail.portNumber = Int(resultSet.int(forColumn: "portNumber"))
                
                setCompanyDetail(credential_detail)
                
                marrCredential.add(Credential)
            }
        }
        sharedInstance.database!.close()
        return marrCredential
    }

}
