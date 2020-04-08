//
//  DepositWithdrawController.swift
//  KVO-Lab
//
//  Created by Maitree Bain on 4/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class DepositWithdrawController: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceStepper: UIStepper!
    
    private var balanceObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBalance()
        updateUI()
    }
    
    private func updateUI() {
        balanceLabel.text = User.shared.balance.description
    }
    
    private func configureBalance() {
        balanceObserver = User.shared.observe(\.balance, options: [.old, .new], changeHandler: { [weak self] (user, change) in
            
            guard let newBalance = change.newValue else { return }
            self?.balanceLabel.text = newBalance.description
        })
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        User.shared.balance = Int(sender.value)
        print(User.shared.balance)
    }
}
