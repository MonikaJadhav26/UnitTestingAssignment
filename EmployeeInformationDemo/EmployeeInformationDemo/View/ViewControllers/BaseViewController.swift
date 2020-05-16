//
//  BaseViewController.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 15/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    var activityIndicator = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Show Alert
    func showAlert(message: String, title : String, action: UIAlertAction) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Method For Adding Navigation Title
    func getTitleForView(navigationTitle : String?) {
        self.title = navigationTitle
    }
    
    //MARK: - Method Activity Indicator
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.center =  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }

    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    //MARK: - Method For Applying Rounded Corners to Button
    func addRoundedCornerToButton(button : UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
}
