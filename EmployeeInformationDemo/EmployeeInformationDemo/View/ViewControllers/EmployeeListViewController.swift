//
//  EmployeeListViewController.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 11/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class EmployeeListViewController: BaseViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var employeeListTableView: UITableView!
    var employeeListViewModel = EmployeeListViewModel()
    var deleteEmployeeViewModel = DeleteEmployeeViewModel()
    
    //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
     override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        getEmployeeListFromURL()
     }
    
    //MARK: - Method for UI setup
    func setUpUI() {
        employeeListTableView.rowHeight = UITableView.automaticDimension
        self.employeeListTableView.register(UINib.init(nibName: Constants.employeeListTableCell, bundle: nil), forCellReuseIdentifier: Constants.kCellIdentifier)
        self.addActivityIndicator()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        employeeListTableView.refreshControl = refreshControl
    }
    
    //MARK: - Pull to refresh method
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        employeeListTableView.reloadData()
        getEmployeeListFromURL()
        refreshControl.endRefreshing()
    }
    
    //MARK: - Add Button Action
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let createViewController = UIStoryboard.init(name: Constants.stodyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.createEmployeeView) as? CreateEmployeeViewController
        self.navigationController?.pushViewController(createViewController!, animated: true)
    }
    
    //MARK: - Call to get all data server
    func getEmployeeListFromURL() {
        self.showActivityIndicator()
        employeeListViewModel.fetchEmployeeData { result in
            switch(result) {
            case .success:
                self.hideActivityIndicator()
                self.getTitleForView(navigationTitle: Constants.employeeListTitle)
                self.employeeListTableView.reloadData()
            case .failure(let error):
                self.hideActivityIndicator()
                self.showAlert(message: error.localizedDescription, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
    
}

//MARK: - UITableview delegate and datasource methods
extension EmployeeListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListViewModel.getNumberOfTotalEmployee(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCellIdentifier, for: indexPath) as! EmployeeListTableViewCell
        cell.employeeNameLabel.text = employeeListViewModel.getEmployeeFullName(indexPath: indexPath)
        cell.employeeAgeLabel.text = employeeListViewModel.getEmployeeAge(indexPath: indexPath)
        cell.employeeSalaryLabel.text = employeeListViewModel.getEmployeeSalary(indexPath: indexPath)
        cell.employeeProfileImage.image = Constants.defaultImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let employee = employeeListViewModel.employeeData[indexPath.row]
            deleteEmployeeViewModel.deleteEmployee(employeeID: Int(employee.id ?? "") ?? 0) { (result) in
                switch(result) {
                case .success(let result):
                    if result.status == Constants.success {
                        self.employeeListTableView.beginUpdates()
                        self.employeeListViewModel.employeeData.remove(at: indexPath.row)
                        self.employeeListTableView.deleteRows(at: [indexPath], with: .fade)
                        self.employeeListTableView.endUpdates()
                    } else {
                        self.showAlert(message: result.message, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                    }
                    
                case .failure(let error):
                    self.showAlert(message: error.localizedDescription, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: - UISearchBar delegate methods
extension EmployeeListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        employeeListViewModel.searchEmployee(with: searchText) {
            self.employeeListTableView.reloadData()
            if searchText.isEmpty {
                searchBar.resignFirstResponder()
            }
        }
    }
}
