//
//  DepositWithdrawController.swift
//  KVO-Lab
//
//  Created by Maitree Bain on 4/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

enum Status {
    case deposit
    case withdraw
}

class DepositWithdrawController: UIViewController {
    
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var valueText: UITextField!
    
    private var balanceObserver: NSKeyValueObservation?
    
    private var status: Status = .deposit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBalance()
        updateUI()
    }
    
    private func updateUI() {
        balanceLabel.text = User.shared.balance.description
        valueText.delegate = self
    }
    
    private func configureBalance() {
        balanceObserver = User.shared.observe(\.balance, options: [.old, .new], changeHandler: { [weak self] (user, change) in
            
            guard let newBalance = change.newValue else { return }
            self?.balanceLabel.text = newBalance.description
        })
    }
    
    
    @IBAction func depositButtonPressed(_ sender: UIButton) {
        status = .deposit
        savingsLabel.text = "Depositing"
        savingsLabel.textColor = .green
    }
    
    
    @IBAction func withdrawButtonPressed(_ sender: UIButton) {
        status = .withdraw
        savingsLabel.text = "Withdrawing"
        savingsLabel.textColor = .red
    }
}

extension DepositWithdrawController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        if status == .deposit {
            if let value = textField.text {
                User.shared.balance += Int(value) ?? 0
            }
        } else {
            if let value = textField.text {
                User.shared.balance -= Int(value) ?? 0
            }
        }
        
        return true
    }
}
