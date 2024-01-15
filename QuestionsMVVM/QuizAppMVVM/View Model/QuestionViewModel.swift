//
//  QuestionViewModel.swift
//  QuizAppMVVM
//
//  Created by Ezgi Karahan on 15.01.2024.
//

import Foundation

class QuestionViewModel{
    
    private var sourceUrl = URL(string: "https://quiz-68112-default-rtdb.firebaseio.com/quiz.json") //url
    var questionModel: DataModel?
    
    //MARK: GET ALL DATAS
    /**Parametre -> completion adında closure
       @escaping -> closureları işaretlemede kullanılır
       () -> () ifadesi, kapanış fonkiyonu hiçbir param almıyor ve hiçbir param dönmüyor .*/
    func getAllTheQuestions(completion: @escaping () -> () ){
        
        URLSession.shared.dataTask(with: sourceUrl!){ [weak self] data, response, error in
            
            if let data = data{
                //jsonDecoder oluşturuluyor:
                let jsonDecoder = JSONDecoder()
                
                // API'den alınan JSON verisi DataModel'e dönüştürülüyor:
                // model structlarından en genişini alıyorum yani = DataModel'i
                let finalModel = try! jsonDecoder.decode(DataModel.self, from: data)
                
                // Elde edilen DataModel nesnesi questionModel'e atanıyor
                self?.questionModel = finalModel
                
                print(finalModel)
                //tamamlanma bloğu çalıştırılıyor.
                completion()
            }
            
        }.resume()
        
    }
}
