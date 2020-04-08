//
//  Accounts.swift
//  KVO-Lab
//
//  Created by Maitree Bain on 4/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation

@objc class Account: NSObject {
    static let shared = Account()
    @objc dynamic var name = [String]()
    @objc dynamic var balance = [Int]()
    
    override private init(){
        name = [""]
        balance = [0]
    }
}
