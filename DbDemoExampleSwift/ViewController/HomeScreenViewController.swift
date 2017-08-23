

import UIKit



class HomeScreenViewController: UIViewController , UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtCompanyName: UILabel!
    @IBOutlet weak var lblsearch: UITextField!
    @IBOutlet weak var tbCustomerData: UITableView!
    var marrCustomerData : NSMutableArray!
    
    var modelManager:ModelManager = ModelManager()
    var presenter:CustomerRecordPresenter = CustomerRecordPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblsearch.delegate = self
        txtCompanyName.text = modelManager.getInstance().companyName
        
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.presenter.getCustomerData()
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func txtLogOut(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "logout1", sender: sender)
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func btnLog(_ sender: AnyObject) {
        presenter.getCustomerData()
        refresh()
    }
    
    @IBAction func SearchEditingChanged(_ sender: AnyObject) {
        
        if (lblsearch.text! == ""){
            
          
            presenter.getSearcResultByFirstName()
            refresh()
        }
        else{
          
           presenter.getSearchResultByFirstName(firstName: lblsearch.text!)
            refresh()
        }
        
    }
    @IBAction func btnSearch(_ sender: AnyObject) {
        marrCustomerData = NSMutableArray()
        
        
        if (lblsearch.text! == ""){
            
            
            presenter.getSearcResultByFirstName()
            refresh()
        }
        else{
            
            presenter.getSearchResultByFirstName(firstName: lblsearch.text!)
            refresh()
        }
    }
    
    
    
  
    //MARK: Other methods
    
    
    
       //MARK: UITableView delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.marrCustomerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StudentCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentCell
        let customer:CustomerInfo = presenter.marrCustomerData.object(at: (indexPath as NSIndexPath).row) as! CustomerInfo
        
        
        
        
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
        
        
        self.presenter.getFirstNameSortedCustomerData()
        refresh()
        
        
        
    }
    @IBAction func sortByLastName(_ sender: AnyObject) {
        self.presenter.getLastNameSortedCustomerData()
        refresh()
        
    }
    
    @IBAction func sortByEmailAddress(_ sender: AnyObject) {
        
        self.presenter.getEmailAddressSortedCustomerData()
        refresh()
        
    }
    
    @IBAction func sortByContactNumber(_ sender: AnyObject) {
        
        
        self.presenter.getPhoneNumberSortedCustomerData()
        refresh()
    }
    
    @IBAction func sortByVisitReason(_ sender: AnyObject) {
        
        self.presenter.getVisitReasonSortedCustomerData()
        refresh()
    }
    
    
    @IBAction func sortByVisitedOn(_ sender: AnyObject) {
        self.presenter.getVisitedOnSortedCustomerData()
        refresh()
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
            let customerInfo: CustomerInfo = self.presenter.marrCustomerData.object(at: selectedIndex) as! CustomerInfo
            let isDeleted = self.presenter.deleteCustomerData(customerInfo: customerInfo)
            
            if isDeleted {
                Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
            } else {
                Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
            }
            
            self.presenter.getCustomerData()
            self.refresh()
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
            viewController.customerData = marrCustomerData.object(at: selectedIndex) as! CustomerInfo
        }
    }
    
    
    private func refresh(){
        tbCustomerData.reloadData()
        
        
    }
    
}
