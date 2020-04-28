//
//  SignUpViewController.swift
//  ToDoPostRequest
//
//  Created by C4Q on 4/28/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.addTarget(self, action: #selector(validateTextField), for: .editingChanged)

    }
    
    //MARK: OBJC Functions
    @objc func validateTextField() {
        guard userNameTextField.hasText else {
            signUpButton.isEnabled = false
            return
        }
        
    }
    
    
    //MARK: Actions
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        guard let text = userNameTextField.text else {return}
        
        let user = User(username: text)
        
        TaskAPIManager.shared.signUp(user: user) { (result) in
            switch result {
            case .success(()):
                let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TasksNavController")
                self.present(vc, animated: true, completion: {
                    UserDefaultsManager.shared.setUserName(userName: text)
                })
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

   

}
