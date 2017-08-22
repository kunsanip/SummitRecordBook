

import UIKit
import CoreData
import MessageUI
class InsertRecordViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtVisitReason: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    
    var CompanyName: String = String()
    var CompanyEmailAddress: String = String()
    var CompanyEmailAddressPassword : String = String()
    var CompanyEmailHost : String = String()
    var CompanyPortNumber: Int = 0
    
    
    
    var pickerData: [String] = [String]()
 
    var isEdit : Bool = false
    var customerData : CustomerInfo!
    
    
    //MARK: LYNDA for MVP tranform
    var validation: Validation!
    
    
    //MARK: LYNDA for MVP transform
    var emailHandling: Email!
    
    var placementAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyLabel.text = ModelManager.getInstance().companyName
        CompanyName = ModelManager.getInstance().companyName
        CompanyEmailAddress = ModelManager.getInstance().companyAddress
        CompanyEmailAddressPassword = ModelManager.getInstance().companyEmailPassword
        CompanyEmailHost = ModelManager.getInstance().emailHost
        CompanyPortNumber = ModelManager.getInstance().portNumber
        validation = Validation()
        emailHandling = Email()
        
        
        self.txtFirstName.delegate = self;
        self.txtEmailAddress.delegate = self;
        self.txtLastName.delegate = self;
        self.txtPhoneNumber.delegate = self;
        self.txtVisitReason.delegate = self;
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        pickerData = ["Renew Visa", "Apply Uni", "Apply PR", "Apply PSW", "Sponsorship","Consult"]
        
        
        if(isEdit)
        {
            
            
            txtFirstName.text = customerData.FirstName
            txtLastName.text = customerData.LastName
            txtEmailAddress.text = customerData.EmailAddress
            
            txtPhoneNumber.text = customerData.PhoneNumber
            
            
            txtVisitReason.text = customerData.ReasonVisit
            
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
        
        
        
    }
    
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
        
    }
    
    
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    // Capture the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        placementAnswer = row
        
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
        //MARK: UIButton Action methods
    
    @IBAction func btnBackClicked(_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: AnyObject)
    {
        
        let email:String = txtEmailAddress.text!
        let phone:String = txtPhoneNumber.text!
        let emailVal:Bool = validation.isValidEmail(email)
        let phoneVal:Bool = validation.validatePhone(phone)
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let dateStamp = (formatter.string(from: now))
        
        if(txtFirstName.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter first name.", delegate: nil)
        }
        else if(txtLastName.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter last name.", delegate: nil)
        }
            
        else if(txtEmailAddress.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter email address.", delegate: nil)
        }
            
        else if(emailVal == false)
        {
            Util.invokeAlertMethod("", strBody: "Invalid email address.", delegate: nil)
        }
            
            
        else if(txtPhoneNumber.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter phone number.", delegate: nil)
        }
            
        else if(phoneVal == false)
        {
            Util.invokeAlertMethod("", strBody: "Invalid phone number.", delegate: nil)
        }
        else if(txtVisitReason.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter reason for visit.", delegate: nil)
        }
            
            
            
            
        else
        {
            if(isEdit)
            {
                let customerInfo: CustomerInfo = CustomerInfo()
                
                customerInfo.VisitNumber = customerData.VisitNumber
                customerInfo.FirstName = txtFirstName.text!
                customerInfo.LastName = txtLastName.text!
                customerInfo.EmailAddress = txtEmailAddress.text!
                customerInfo.PhoneNumber = txtPhoneNumber.text!
                customerInfo.ReasonVisit = txtVisitReason.text!
                customerInfo.TimeStamp = dateStamp
                
                let isUpdated = ModelManager.getInstance().updateStudentData(customerInfo)
                if isUpdated {
                    Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                }
            }
            else
            {
                let customerInfo: CustomerInfo = CustomerInfo()
                
                
                customerInfo.FirstName = txtFirstName.text!
                customerInfo.LastName = txtLastName.text!
                customerInfo.EmailAddress = txtEmailAddress.text!
                customerInfo.PhoneNumber = txtPhoneNumber.text!
                customerInfo.ReasonVisit = txtVisitReason.text!
                customerInfo.TimeStamp = dateStamp
                
                
                let isInserted = ModelManager.getInstance().addStudentData(customerInfo)
                if isInserted {
                    Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                }
            }
            //emailHandling.MailCore(name: txtFirstName.text!,emailAddress: txtEmailAddress.text!)
            
            
            emailHandling.MailCoreUser(name: txtFirstName.text!, emailAddress: txtEmailAddress.text!, companyName: CompanyName, companyAddress: CompanyEmailAddress, companyPassword: CompanyEmailAddressPassword, companyHost: CompanyEmailHost, companyPortNumber: CompanyPortNumber)
            
            emailHandling.MailCoreCompany(name: txtFirstName.text!, emailAddress: txtEmailAddress.text!, companyName: CompanyName, companyEmailAddress: CompanyEmailAddress, companyPassword: CompanyEmailAddressPassword, companyHost: CompanyEmailHost,companyPortNumber: CompanyPortNumber)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
        
    @IBAction func didEndOnExit(_ sender: Any) {
        
        
        self.resignFirstResponder()
    }
    
    @IBAction func Submit(_ sender: Any) {
        
        if (placementAnswer == 0){
            
            txtVisitReason.text = "Renew Visa"
            
        }
            
        else if (placementAnswer == 1){
            
            txtVisitReason.text = "Apply Uni"
        }
            
        else if (placementAnswer == 2 ){
            txtVisitReason.text = "Apply PR"
            
            
            
        }
        else if (placementAnswer == 3 ){
            txtVisitReason.text = "Apply PSW"
            
            
            
        }
        else if (placementAnswer == 4 ){
            txtVisitReason.text = "Sponsorship"
            
            
            
        }
            
        else  {
            txtVisitReason.text = "Consult"
            
            
        }
        
        
    }
    
    @IBAction func txtLogOut(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "logout2", sender: sender)
    }
    
    
}
