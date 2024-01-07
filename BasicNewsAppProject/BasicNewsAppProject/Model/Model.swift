//
//  Model.swift
//  BasicNewsAppProject
//
//  Created by Ezgi Karahan on 7.01.2024.
//

import Foundation


//burada decodable kullanarak verileri cekiyorum:
// decodable get yani veriyi okuma işlemlerinde kullanılır.

struct Model : Decodable {
    
    var title : String?
    var description: String?
    var urlToImage : String?
}

//yukarıdakiler articles dizisinin içerisinde:

struct NewResponse : Decodable {
    var articles = [Model]() //hoca derste [Model] yapıyor. bende hata veriyor.
}
