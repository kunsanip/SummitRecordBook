

import UIKit
import CoreData
import MessageUI
class InsertRecordViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    var placementAnswer = 0
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var Label: UILabel!
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
    
    @IBAction func txtLogOut(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "logout2", sender: sender)
    }
    
    var isEdit : Bool = false
    var customerData : CustomerInfo!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyLabel.text = ModelManager.getInstance().companyName
        CompanyName = ModelManager.getInstance().companyName
        CompanyEmailAddress = ModelManager.getInstance().companyAddress
        CompanyEmailAddressPassword = ModelManager.getInstance().companyEmailPassword
        CompanyEmailHost = ModelManager.getInstance().emailHost
        CompanyPortNumber = ModelManager.getInstance().portNumber
        
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
    
    func isValidEmail(_ email:String!) -> Bool{
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    func validatePhone(_ phonenumber: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phonenumber)
        return result
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
        let emailVal:Bool = isValidEmail(email)
        let phoneVal:Bool = validatePhone(phone)
        
        
        
        
        
        
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
            //MailCore(name: txtFirstName.text!,emailAddress: txtEmailAddress.text!)
            MailCoreUser(name: txtFirstName.text!, emailAddress: txtEmailAddress.text!, companyName: CompanyName, companyAddress: CompanyEmailAddress, companyPassword: CompanyEmailAddressPassword, companyHost: CompanyEmailHost, companyPortNumber: CompanyPortNumber)
             MailCoreCompany(name: txtFirstName.text!, emailAddress: txtEmailAddress.text!, companyName: CompanyName, companyEmailAddress: CompanyEmailAddress, companyPassword: CompanyEmailAddressPassword, companyHost: CompanyEmailHost,companyPortNumber: CompanyPortNumber)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // This one is used at the moment: 2nd app submission
    private func MailCore( name: String, emailAddress:String){
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "sanipcr7@gmail.com"
        smtpSession.password = "Cristiano7"
        smtpSession.port = 465
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        var sanip: String  = String()
        sanip = emailAddress
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: name, mailbox: sanip)]
        
        builder.header.from = MCOAddress(displayName: "Sanip Shrestha", mailbox: "brothers@gmail.com")
        builder.header.subject = ""
        builder.htmlBody = "Hi \(name), <br>Thank you for visiting us! <br>You have been successfully registered in our Record Book."
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
    //This method is necessary for ideal scenario when sending email
    private func MailCoreUser( name: String, emailAddress:String, companyName: String, companyAddress: String, companyPassword: String, companyHost: String, companyPortNumber: Int){
        
        print(companyHost)
        print(companyName)
        print(companyAddress)
        print(companyPassword)
        print(companyPortNumber)
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = companyHost
        smtpSession.username = companyAddress
        smtpSession.password = companyPassword
        smtpSession.port = UInt32(companyPortNumber)
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        var sanip: String  = String()
        sanip = emailAddress
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: name, mailbox: sanip)]
        
        builder.header.from = MCOAddress(displayName: companyName, mailbox: "noreply")
        builder.header.subject = "Thank you for visiting us."
        builder.htmlBody = "Hi \(name), <br><br>You have been successfully registered in our Record Book.<br><br>Thank you for visiting us! <br><br>Kind regards,<br>\(companyName)"
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
    //Ideal scenario for sending company email 
    private func MailCoreCompany( name: String, emailAddress:String, companyName:String, companyEmailAddress:String, companyPassword: String, companyHost: String, companyPortNumber: Int){
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = companyHost
        smtpSession.username = companyEmailAddress
        smtpSession.password = companyPassword
        smtpSession.port = UInt32(companyPortNumber)
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        var userEmail: String = String()
        userEmail = emailAddress
        
        var companyAddress: String  = String()
        companyAddress = companyEmailAddress
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Summit Record Book", mailbox: companyAddress)]
        builder.header.from = MCOAddress(displayName: "Summit Record Book", mailbox: "Headquarter")
        builder.header.subject = "New customer has been recorded in Summit Record Book."
        builder.htmlBody = "<br><h3>Customer Detail</h3><p>Name: \(name) </p><p>Email: \(userEmail)"
        
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }

    
    @IBAction func didEndOnExit(_ sender: Any) {
        
        
        self.resignFirstResponder()
    }
    
}
