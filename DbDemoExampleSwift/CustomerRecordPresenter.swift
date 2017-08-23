//
//  CustomerRecordPresenter.swift
//  Customer Record Summit
//
//  Created by Admin on 8/22/17.
//  Copyright © 2017 Summit. All rights reserved.
//

import Foundation


class CustomerRecordPresenter {
    var modelManager:ModelManager = ModelManager()
    var marrCustomerData : NSMutableArray! }




//MARK: Home Screen View Controller Presenter
extension CustomerRecordPresenter{

     
    func getCustomerData()
    {
        marrCustomerData = NSMutableArray()
        marrCustomerData = modelManager.getInstance().getAllCustomerData()
        
      
    }
    
    //MARK: FIRST NAME SORTED
    func getFirstNameSortedCustomerData()
    {
        marrCustomerData = NSMutableArray()
        marrCustomerData = modelManager.getInstance().getSortedByFirstName()
    
    }
    
    //MARK: LAST NAME SORTED
    func getLastNameSortedCustomerData()
    {
        marrCustomerData = NSMutableArray()
        marrCustomerData = modelManager.getInstance().getSortedByLastName()
   
    }//MARK: EMAIL ADDRESS NAME SORTED
    func getEmailAddressSortedCustomerData()
    {
        marrCustomerData = NSMutableArray()
        marrCustomerData = modelManager.getInstance().getSortedByEmailAddress()

    }//MARK: PHONE NUMBER NAME SORTED
    func getPhoneNumberSortedCustomerData()
    {
        marrCustomerData = NSMutableArray()
        marrCustomerData = modelManager.getInstance().getSortedByPhoneNumber()
       
    }//MARK: REASON VISIT NAME SORTED
    func getVisitReasonSortedCustomerData()
    {
        marrCustomerData = NSMutableArray()
        marrCustomerData = modelManager.getInstance().getSortedByVisitReason()
        
    }//MARK: VISITEDON NAME SORTED
    func getVisitedOnSortedCustomerData()
    {
        marrCustomerData = NSMutableArray()
        marrCustomerData = modelManager.getInstance().getSortedByVisitedOn()
            }
    

    func getSearcResultByFirstName(){
    
        marrCustomerData = modelManager.getInstance().getSearchResultbyFirstName("%")

    }
    
    func getSearchResultByFirstName(firstName: String){
        
        marrCustomerData = modelManager.getInstance().getSearchResultbyFirstName(firstName)
    }
    
    func deleteCustomerData(customerInfo: CustomerInfo) -> Bool{
        let delbool:Bool = modelManager.getInstance().deleteStudentData(customerInfo)
        return delbool
    }
    


}
// MARK: Extentions with Email functions
extension CustomerRecordPresenter{


}
