//
//  MovieModel.swift
//  MoviesAPI
//
//  Created by Ezgi Karahan on 6.01.2024.
//

import Foundation

struct MovieModel : Decodable{  //internetten çekeceğim için decodable olması gerekli
    
    //üst başlıklar: title, description, movies
    var title: String?
    var description: String
    var movies = [Movies]() //boş dizi şeklinde tanımladım
    //kaynakta [Movies] şeklinde tanımlama yapılıyor ama benim kodumda hata alıyorum.
}

struct Movies: Decodable{
    var id: String?
    var title: String?
    var releaseYear: String?
}
