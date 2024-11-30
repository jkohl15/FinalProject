//
//  VisitorCenterModel.swift
//  Assignment4App
//
//  Created by Jeff Kohl on 10/30/24.
//

import Foundation

struct VisitorCenterResults : Codable {
    let total : String
    let limit : String
    let start : String
    let data : [VisitorCenterModel]

}

struct VisitorCenterModel : Codable, Identifiable {
    var id : String
    //let id = UUID()
    let name : String
    let parkCode : String
    let latitude : String
    let longitude : String
    let description: String
}
