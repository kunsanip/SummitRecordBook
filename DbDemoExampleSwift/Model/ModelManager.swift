

import UIKit
import CoreData

class ModelManager: NSObject {
    
    fileprivate var databaseLayer = DataLayer()
    func getInstance() -> DataLayer
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("customerDB.sqlite"))
        }
        return sharedInstance
    }
}

