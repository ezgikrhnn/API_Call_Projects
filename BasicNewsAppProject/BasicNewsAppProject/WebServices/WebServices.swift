//
//  WebServices.swift
//  BasicNewsAppProject
//
//  Created by Ezgi Karahan on 7.01.2024.
//

//MARK: API FOnksiyonlarını bu sınıfta tanımladım: DAHA OKUNABİLİR OLMASI İÇİN

import Foundation

class WebServices {
    
    //webservisin static bir örneğini oluşturdum.
    static let shared = WebServices()
    
    private init(){ //const oluşturdum.
        
    }
    
    
    func fetchData(completion : @escaping ([Model]?) -> Void){
        
        //bana Model sınıfından bir dizi döndürmesini istiyorum, dizi boş olacak.
        //escaping olarak yapılan işlem data, response, error olarak verilen işlemdir.
        
        var urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
     
        //dataTask with: request ya da with:url ile yapılabilir.
        //aşağıda url kullandım.
        if let url = URL(string: urlString){
            
            URLSession.shared.dataTask(with: url){ data, response, error in //cevaplar geldi.
                
                if error != nil {
                    //hata var demektir
                    print(error?.localizedDescription)
                }
                else
                {
                    //hata yok işleme geç
                    do{
                        //json verilerini model dizisine dönüştürüyorum: DECODE:
                        let result = try JSONDecoder().decode(NewResponse.self, from: data!)
                        completion(result.articles) 
                        
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }.resume()
            
        }
    }
    
}

/**completion closure'ı, fetchData fonksiyonu içindeki asenkron işlemin tamamlandığını ve sonuçların kullanılabilir olduğunu belirtmek için kullanılır. @escaping etiketi, closure'ın fonksiyondan çıkış yaptıktan sonra da kullanılabileceğini belirtir.
 
*/
