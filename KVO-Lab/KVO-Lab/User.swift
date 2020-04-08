//
//  User.swift
//  KVO-Lab
//
//  Created by Maitree Bain on 4/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import Foundation

@objc class User: NSObject {
    static let shared = User()
    @objc dynamic var name = ""
    @objc dynamic var balance = 0
    
    override private init(){
        name = ""
        balance = 0
    }
}
