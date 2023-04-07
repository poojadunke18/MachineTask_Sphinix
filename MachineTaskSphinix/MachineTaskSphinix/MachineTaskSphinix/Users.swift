//
//  Users.swift
//  MachineTaskSphinix
//
//  Created by Mac on 21/03/23.
//

import Foundation
struct Users {
    let id : Int
    let name : String
    let gender : String
    
    init (id: Int, name: String, gender : String){
        self.id = id
        self.name = name
        self.gender = gender
    }
}
