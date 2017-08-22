

import UIKit



class HomeScreenViewController: UIViewController , UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtCompanyName: UILabel!
    @IBOutlet weak var lblsearch: UITextField!
    @IBOutlet weak var tbStudentData: UITableView!
    var marrStudentData : NSMutableArray!
    
    
    
    
    @IBAction func txtLogOut(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "logout1", sender: sender)
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnLog(_ sender: AnyObject) {
        getStudentData()
    }
    
    @IBAction func SearchEditingChanged(_ sender: AnyObject) {
        marrStudentData = NSMutableArray()
        
        if (lblsearch.text! == ""){
            
            print("yes")
            marrStudentData = ModelManager.getInstance().getSearchResultbyFirstName("%")
            refresh()
        }
        else{
            print("no")
            marrStudentData = ModelManager.getInstance().getSearchResultbyFirstName(lblsearch.text!)
            refresh()
        }
        
    }
    @IBAction func btnSearch(_ sender: AnyObject) {
        marrStudentData = NSMutableArray()
        
        print(lblsearch.text!)
        
        if (lblsearch.text! == ""){
            
            print("yes")
            marrStudentData = ModelManager.getInstance().getSearchResultbyFirstName("%")
            refresh()
        }
        else{
            print("no")
            marrStudentData = ModelManager.getInstance().getSearchResultbyFirstName(lblsearch.text!)
            refresh()        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblsearch.delegate = self
        txtCompanyName.text = ModelManager.getInstance().companyName
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getStudentData()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Other methods
    
    
    
    func getStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getAllStudentData()
        
        refresh()
    }
    
    //MARK: FIRST NAME SORTED
    func getFirstNameSortedStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getSortedByFirstName()
        refresh()
    }
    
    //MARK: LAST NAME SORTED
    func getLastNameSortedStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getSortedByLastName()
        refresh()
    }//MARK: EMAIL ADDRESS NAME SORTED
    func getEmailAddressSortedStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getSortedByEmailAddress()
        refresh()
    }//MARK: PHONE NUMBER NAME SORTED
    func getPhoneNumberSortedStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getSortedByPhoneNumber()
        refresh()
    }//MARK: REASON VISIT NAME SORTED
    func getVisitReasonSortedStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getSortedByVisitReason()
        refresh()
    }//MARK: VISITEDON NAME SORTED
    func getVisitedOnSortedStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getSortedByVisitedOn()
        refresh()    }
    
    //MARK: UITableView delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marrStudentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StudentCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentCell
        let customer:CustomerInfo = marrStudentData.object(at: (indexPath as NSIndexPath).row) as! CustomerInfo
        
        
        
        
        cell.lblContent.text = "\(customer.FirstName)"
        
        
        cell.lblLastName.text = "\(customer.LastName)"
        
        cell.lblEmailAddress.text = "\(customer.EmailAddress)"
        
        
        cell.lblPhoneNumber.text = "\(customer.PhoneNumber)"
        
        cell.lblVisitReason.text = "\(customer.ReasonVisit)"
        
        cell.lblTimeStamp.text = "\(customer.TimeStamp)"
        
        
        cell.btnDelete.tag = (indexPath as NSIndexPath).row
        cell.btnEdit.tag = (indexPath as NSIndexPath).row
        return cell
    }
    
    @IBAction func sortByFirstName(_ sender: AnyObject) {
        
        
        self.getFirstNameSortedStudentData()
        
        
        
    }
    @IBAction func sortByLastName(_ sender: AnyObject) {
        self.getLastNameSortedStudentData()
        
        
    }
    
    @IBAction func sortByEmailAddress(_ sender: AnyObject) {
        
        self.getEmailAddressSortedStudentData()
        
        
    }
    
    @IBAction func sortByContactNumber(_ sender: AnyObject) {
        
        
        self.getPhoneNumberSortedStudentData()
        
    }
    
    @IBAction func sortByVisitReason(_ sender: AnyObject) {
        
        self.getVisitReasonSortedStudentData()
    }
    
    
    @IBAction func sortByVisitedOn(_ sender: AnyObject) {
        self.getVisitedOnSortedStudentData()
    }
    
    
    @IBAction func btnDeleteClicked(_ sender: AnyObject) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Warning", message: "Are you sure want to delete this record", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            let btnDelete : UIButton = sender as! UIButton
            let selectedIndex : Int = btnDelete.tag
            let customerInfo: CustomerInfo = self.marrStudentData.object(at: selectedIndex) as! CustomerInfo
            let isDeleted = ModelManager.getInstance().deleteStudentData(customerInfo)
            
            
            if isDeleted {
                Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
            } else {
                Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
            }
            
            self.getStudentData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func btnEditClicked(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "editSegue", sender: sender)
    }
    
    //MARK: Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewController : InsertRecordViewController = segue.destination as! InsertRecordViewController
            viewController.isEdit = true
            viewController.customerData = marrStudentData.object(at: selectedIndex) as! CustomerInfo
        }
    }
    
    
    private func refresh(){
        tbStudentData.reloadData()
        
        
    }
    
}
