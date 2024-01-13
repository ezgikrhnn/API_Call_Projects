//
//  ViewController.swift
//  kanyeProject
//
//  Created by Ezgi Karahan on 13.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    var model: [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func quoteButton(_ sender: Any) {
        let url = URL(string: "https://api.kanye.rest/") //url
        var request = URLRequest(url: url!)  //istek
        request.httpMethod = "GET" //cinsi
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //istek gitti cevap geldi
        URLSession.shared.dataTask(with: request){ data, response, error in
           
            if error != nil{ //hata var
                print(error?.localizedDescription)
                print("hata var")
                
            }else{
                //hata yok verileri al
                //verileri do try catch ile alıyorum
                do{
                    if let json = try! JSONSerialization.jsonObject(with: data!, options: []) as?
                        [String:String] { //casting işlemi
                        print(json)
                        
                        //burada json içindeki elemanların hepsini alıyorum.
                        if let quote = json["quote"] {
                            self.model.append(Model(quote: quote))
                            
                            DispatchQueue.main.async {
                                self.quoteLabel.text = quote
                            }

                        }
                        
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

