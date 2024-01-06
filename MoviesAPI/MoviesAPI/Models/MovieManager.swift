//
//  MovieManager.swift
//  MoviesAPI
//
//  Created by Ezgi Karahan on 6.01.2024.
//

import Foundation

//networking işlemleri için bu dosyayı oluşturdum:

struct MovieManager {
    
    func fetchMovies(completion: @escaping(MovieModel) -> ()){ // -> () return nothing demek
        let url = URL(string: "https://reactnative.dev/movies.json")
        
        //data task:
        let dataTask = URLSession.shared.dataTask(with: url!) { data, __, error in //urlresponse ihtiyacım olmadıgı için __ kullandım.
            if let error = error{
                print(error.localizedDescription)
            }
            
            //MARK: Decoding:
            guard let jsonData = data else {return}
            let decoder = JSONDecoder()
           
            
            do{
                let decodedData = try decoder.decode(MovieModel.self, from: jsonData)
                completion(decodedData)
            }catch{
                print("Error to decoding data")
            }
        }
        dataTask.resume() //yapılmazsa kod çalışmaz
        
    }
    
}
