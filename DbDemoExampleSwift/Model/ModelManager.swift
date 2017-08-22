

import UIKit
import CoreData

class ModelManager: NSObject {
    
    
    fileprivate var databaseLayer = DatabaseLayer()


    
     func getInstance() -> DatabaseLayer
    {
        if(sharedInstance.database == nil)
        {
            
            sharedInstance.database = FMDatabase(path: Util.getPath("customerDB.sqlite"))
        }
        
      
        print(sharedInstance)
        return sharedInstance
    }
    
    

    }
    
