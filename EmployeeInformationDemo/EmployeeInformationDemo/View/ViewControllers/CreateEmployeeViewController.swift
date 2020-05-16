//
//  CreateEmployeeViewController.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class CreateEmployeeViewController: BaseViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!{
        didSet {
            ageTextField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTappedForAgeTextField)))
        }    }
    @IBOutlet weak var salaryTextField: UITextField!{
        didSet { salaryTextField?.addDoneCancelToolbar() }
    }
    @IBOutlet weak var createButton: UIButton!
    var createEmployeeViewModel = CreateEmployeeViewModel()

    //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    //MARK: - Method for UI setup
    func setUpUI() {
        self.addActivityIndicator()
        createButton.isEnabled = false
        self.addRoundedCornerToButton(button : createButton)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        self.getTitleForView(navigationTitle: Constants.createNewEmployeeTitle)
        nameTextField.addTarget(self, action: #selector(CreateEmployeeViewController.textFieldDidChange(_:)), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(CreateEmployeeViewController.textFieldDidChange(_:)), for: .editingChanged)
        salaryTextField.addTarget(self, action: #selector(CreateEmployeeViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if !((nameTextField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && !((ageTextField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && !((salaryTextField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!{
            
            createButton.isEnabled = true
            createButton.backgroundColor = Constants.greenButtonColour
        } else {
            createButton.isEnabled = false
            createButton.backgroundColor = .lightGray
        }
    }
    
    @objc func doneButtonTappedForAgeTextField() {
        salaryTextField.becomeFirstResponder()
    }

    @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    
    func resetTextField() {
        nameTextField.text = ""
        ageTextField.text = ""
        salaryTextField.text = ""
    }
    
    
    //MARK: - Create Button Action Method
    @IBAction func createButtonClicked(_ sender: UIButton) {
        self.showActivityIndicator()
        
        let newEmployeeInfo = EmployeeInfo(name: (nameTextField.text)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", salary: (salaryTextField.text)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", age: (ageTextField.text)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "", id: 0)
        
        createEmployeeViewModel.createNewEmployee(newEmployee: newEmployeeInfo) { result in
                   switch(result) {
                   case .success:
                    self.hideActivityIndicator()
                    self.resetTextField()
                    self.showAlert(message: Constants.cresteEmployeeSuccessMessage,title : Constants.message, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                   case .failure(let error):
                    self.hideActivityIndicator()
                    self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                   }
               }
    }
    
}

//MARK: - UITextField Delegate Methods
extension CreateEmployeeViewController : UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            ageTextField.becomeFirstResponder()
        } else if textField == ageTextField {
            salaryTextField.becomeFirstResponder()
        }
        return true
    }
}
