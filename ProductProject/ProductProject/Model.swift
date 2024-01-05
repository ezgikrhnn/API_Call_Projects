//
//  Model.swift
//  ProductProject
//
//  Created by Ezgi Karahan on 3.01.2024.
//

import Foundation

//Json parse ile verrileri aldım:



struct Model: Codable{
    var title: String?
    var description: String?
    var price: Int?
    var thumbnail: String?
    var images = [Images]()  //[Images]?  yaptıgımda hem burada hem viewcontrollerde işleme aşamasında hata alıyorum.
}

struct Images: Codable {
    var images: String?
    
}
