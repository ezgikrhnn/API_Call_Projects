//
//  ViewController.swift
//  HavaDurumuApp
//
//  Created by Ezgi Karahan on 26.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CurrentTempLabel: UILabel!
    @IBOutlet weak var WindSpeedLabel: UILabel!
    @IBOutlet weak var FeelsLikeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func GetButtonClicked(_ sender: Any) {
        
        //MARK: 1. Adım: Web adresine git, istek gönder
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=41.026006&lon=29.013713&appid=168511883781ebc0168f4b85ffe4ce1c")
        
        let session = URLSession.shared ///urlsessiondan sonra task oluşturuluyor
        let task = session.dataTask(with: url!) { data, response, error in
            
            ///burada kontrollerimi yapmam gerekiyor.
            ///error kontrolu:
            if error != nil {
                print("error")
            }else{ //MARK: 2. Adım: Datayı al
                if data != nil {///simdi data kontrolü yapıyorum
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!,
                                                                            options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                        ///Alınan veri JSON formatındaysa, bu veriyi işlemek için JSONSerialization sınıfı kullanılır. Eğer JSON verisi başarıyla işlenirse, bu veri [String:Any] tipinde bir sözlük (dictionary) olarak jsonResponse değişkenine atanır
                        
                        ///JSON verisinin işlenmesi tamamlandıktan sonra, bu işlemleri ana koda dönmek ve UI güncellemelerini yapmak için DispatchQueue.main.async kullanılır.Bu adımlar, OpenWeatherMap API'den hava durumu verilerini çekmek ve bu verileri kullanıcı arayüzünde göstermek için bir işlem akışını temsil eder.
                        DispatchQueue.main.async {
                            if let main = jsonResponse!["main"] as? [String:Any]{
                                if let temp = main["temp"] as? Double {
                                    self.CurrentTempLabel.text = String(Int(temp-272.15))
                                }
                                if let feels_like = main["feels_like"] as? Double {
                                    self.FeelsLikeLabel.text = String(Int(feels_like-272.15))
                                }
                                
                            }
                            if let wind = jsonResponse!["wind"] as? [String:Any] {
                                if let speed = wind["speed"] as? Double {
                                    self.WindSpeedLabel.text = String(Int(speed))
                                }
                            }
                        }
                    }catch{
                        
                    }
                }
            }
        }
        task.resume() ///bunu yazmayı unutursan session işlemin gerçekleşmez, task parantezinde resume() kullanılır.
    }
    //1. web adresine gitme
    //2. Datayı al
    //3. Datayı işle
    
}

