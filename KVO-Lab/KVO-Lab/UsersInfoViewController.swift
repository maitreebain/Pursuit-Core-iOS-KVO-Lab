//
//  UsersInfoViewController.swift
//  KVO-Lab
//
//  Created by Maitree Bain on 4/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class UsersInfoViewController: UIViewController {

    @IBOutlet weak var balanceTableView: UITableView!
    
    private var accountObserver: NSKeyValueObservation?
    private var balanceObserver: NSKeyValueObservation?
    
    var account = Account.shared.users{
        didSet{
            DispatchQueue.main.async {
                self.balanceTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        balanceTableView.dataSource = self
        configureAccountObserver()
    }
    
    private func configureAccountObserver() {
        accountObserver = Account.shared.observe(\.users, options: [.old, .new], changeHandler: { (account, change) in

            guard let oldUsers = change.oldValue,let newUsers = change.newValue else { return }
            self.account = newUsers
        })
    }

}

extension UsersInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return account.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "balanceCell", for: indexPath)
    
        let value = account[indexPath.row]
        cell.textLabel?.text = "\(value.name)"
        cell.detailTextLabel?.text = "\(value.balance)"
        
        if value.name == User.shared.name {
            balanceObserver = User.shared.observe(\.balance, options: [.old, .new], changeHandler: {(user, change) in
                
                guard let newBalance = change.newValue else { return }
                cell.detailTextLabel?.text = "\(newBalance)"
            })
        }
        
        return cell
    }
    
    
}
