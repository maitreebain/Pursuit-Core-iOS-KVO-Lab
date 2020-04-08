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
    
    var account = [Account.shared]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        balanceTableView.dataSource = self
    }

}

extension UsersInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return account.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "balanceCell", for: indexPath)
    
        let value = account[indexPath.row]
        cell.textLabel?.text = "\(value.name.last ?? "no name")"
        cell.detailTextLabel?.text = "\(value.balance.last ?? 0)"
        
        accountObserver = Account.shared.observe(\.balance, options: [.old, .new], changeHandler: { (account, change) in
        
            cell.detailTextLabel?.text = "\(change.newValue?.first ?? 0)"
        })
        
        return cell
    }
    
    
}
