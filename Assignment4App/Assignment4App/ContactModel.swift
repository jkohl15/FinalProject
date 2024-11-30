//
//  ContactModel.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 10/30/24.
//

import Foundation

struct ContactModel : Codable {
    let phoneNumbers : [PhoneModel]
    let emailAddresses : [EmailModel]
}

struct PhoneModel : Codable {
    let phoneNumber : String
    let description : String
    let `extension` : String
    let type : String
}

struct EmailModel: Codable {
    let description : String
    let emailAddress : String
}
