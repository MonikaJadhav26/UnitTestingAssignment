//
//  EmployeeListViewController.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 11/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {

    //MARK: - Outlets and Variables
    @IBOutlet weak var employeeListTableView: UITableView!
    var employeeListViewModel = EmployeeListViewModel()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        getEmployeeListFromURL()
    }
   
    //MARK: - Method for UI setup
    func setUpUI() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        employeeListTableView.separatorStyle = .none
        employeeListTableView.rowHeight = UITableView.automaticDimension
        employeeListTableView.tableFooterView = UIView()
        employeeListTableView.delegate = self
        employeeListTableView.dataSource = self
       self.employeeListTableView.register(UINib.init(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: kCellIdentifier)
    }
    
    //MARK: - Call to get all data server
       func getEmployeeListFromURL() {
           employeeListViewModel.fetchEmployeeData() {
               DispatchQueue.main.async {
                self.title = self.employeeListViewModel.getTitleForView()
                  // self.tableView.reloadData()
               }
           }
       }
}

extension EmployeeListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! EmployeeListTableViewCell
        cell.employeeNameLabel.text = "Monika Jadhav"
        cell.employeeAgeLabel.text = "30"
        cell.employeeSalaryLabel.text = "50000"
        cell.employeeProfileImage.image = defaultImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
