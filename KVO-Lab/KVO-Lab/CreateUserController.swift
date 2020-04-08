//
//  ViewController.swift
//  KVO-Lab
//
//  Created by Maitree Bain on 4/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class CreateUserController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var balanceText: UITextField!
    
    private var balanceObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameText.delegate = self
        balanceText.delegate = self
        configureBalance()
    }
    
    private func configureBalance() {
        balanceObserver = User.shared.observe(\.balance, options: [.old, .new], changeHandler: { [weak self] (user, change) in
            
            guard let newBalance = change.newValue else { return }
            self?.balanceText.text = newBalance.description
        })
    }

}

extension CreateUserController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let newUser = User()
        
        if let name = usernameText.text, let balance = balanceText.text {
            newUser.name = name
            newUser.balance = Int(balance) ?? 0
            Account.shared.users.append(newUser)
            
        }
        textField.resignFirstResponder()
        
        return true
    }
    
}
