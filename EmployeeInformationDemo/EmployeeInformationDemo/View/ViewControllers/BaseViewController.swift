//
//  BaseViewController.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 15/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Show Alert
    func showAlert(message: String, action: UIAlertAction) {
        let alert = UIAlertController(title: Constants.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Method For Adding Navigation Title
    func getTitleForView(navigationTitle : String?) {
        self.title = navigationTitle
    }

}
