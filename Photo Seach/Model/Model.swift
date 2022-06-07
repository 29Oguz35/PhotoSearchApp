//
//  Model.swift
//  Photo Seach
//
//  Created by naruto kurama on 26.04.2022.
//

import UIKit

struct APIResponse : Codable {
    let total : Int
    let total_pages : Int
    let results : [Result]
    init(dictionary :[String : Any] ) {
        self.total = dictionary["total"] as? Int ?? 0
        self.total_pages = dictionary["total_pages"] as? Int ?? 0
        self.results = dictionary["results"] as! [Result]
    }
}
struct Result : Codable {
    let id : String
    let urls : URLS
    
    init(dictionary : [String : Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.urls = dictionary["urls"] as! URLS
    }
}
struct URLS : Codable {
    let regular :String
    
    init(dictionary : [String : Any]) {
        self.regular = dictionary["regular"] as? String ?? ""
    }
}
