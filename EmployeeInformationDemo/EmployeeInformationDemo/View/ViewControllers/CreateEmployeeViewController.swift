//
//  CreateEmployeeViewController.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import UIKit

class CreateEmployeeViewController: UIViewController {
    
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


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    //MARK: - Method for UI setup
    func setUpUI() {
        createButton.isEnabled = false
        self.title = "Create New Employee"
    }
    
    @objc func doneButtonTappedForAgeTextField() {
        salaryTextField.becomeFirstResponder()
    }
    
    @IBAction func createButtonClicked(_ sender: UIButton) {
        
        let newEmployeeInfo = EmployeeInfo(name: nameTextField.text, salary: salaryTextField.text, age: ageTextField.text, id: "")
        
        createEmployeeViewModel.createNewEmployee(newEmployee: newEmployeeInfo) { result in
                   switch(result) {
                   case .success:
                       self.navigationController?.popToRootViewController(animated: true)
                   case .failure(let error):
                       let alert = UIAlertController(title: "Error", message: error.localizedDescription , preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   }
               }
    }
    
}

extension CreateEmployeeViewController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text ?? "")
        if nameTextField.text!.count < 1  || ageTextField.text!.count < 1 || salaryTextField.text!.count < 1 {
            createButton.isEnabled = false
            createButton.backgroundColor = .lightGray
        } else {
            createButton.isEnabled = true
            createButton.backgroundColor = Constants.greenButtonColour
        }
       
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            ageTextField.becomeFirstResponder()
        } else if textField == ageTextField {
            salaryTextField.becomeFirstResponder()
        }
        return true
    }
}
