//
//  CustomersViewController.swift
//  Customer Record Summit
//
//  Created by Sanip Shrestha on 6/16/19.
//  Copyright © 2019 Summit. All rights reserved.
//

import UIKit

class CustomersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var presenter:CustomersPresenter = CustomersPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenter.getCustomerData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StudentInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StudentInfoTableViewCell
        let customer:CustomerInfo = presenter.getCustomerData().object(at: (indexPath as NSIndexPath).row) as! CustomerInfo
        
        cell.studentName.text = "\(customer.FirstName)"
        print("Hello : \(cell.studentName.text)")
        return cell
    }
}

