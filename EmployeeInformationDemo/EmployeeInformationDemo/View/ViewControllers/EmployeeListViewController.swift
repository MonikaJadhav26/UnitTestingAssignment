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
        
        employeeListTableView.separatorStyle = .none
        employeeListTableView.rowHeight = UITableView.automaticDimension
        employeeListTableView.tableFooterView = UIView()
        employeeListTableView.delegate = self
        employeeListTableView.dataSource = self
        self.employeeListTableView.register(UINib.init(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: Constants.kCellIdentifier)
    }
        
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let createViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateEmployeeViewController") as? CreateEmployeeViewController
        self.navigationController?.pushViewController(createViewController!, animated: true)
    }
    
    //MARK: - Call to get all data server
    func getEmployeeListFromURL() {
        employeeListViewModel.fetchEmployeeData { result in
            switch(result) {
            case .success:
                self.title = self.employeeListViewModel.getTitleForView()
                self.employeeListTableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

extension EmployeeListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListViewModel.getNumberOfFacts(section: section)
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
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension EmployeeListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        employeeListViewModel.searchEmployee(with: searchText) {
//            self.employeeListTableView.reloadData()
//            if searchText.isEmpty {
//                searchBar.resignFirstResponder()
//            }
//        }
    }
}
