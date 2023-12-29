//
//  ViewController.swift
//  FakeAPI
//
//  Created by Ezgi Karahan on 29.12.2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    
    var model : [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        
        //MARK: COLLECTIONVİEW TASARIMI:
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        // 10 item 10 item 10 = toplamda yatayda 30 boşluk var
        let ekranGenisliği = UIScreen.main.bounds.width ///ekran genişliğni verir
        let itemGenislik = (ekranGenisliği - 30) / 2
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.6)
        ProductCollectionView.collectionViewLayout = tasarim
        
        verileriGetir()
    }
    
    //MARK: - Verileri Getir:
    func verileriGetir(){
        var url = "https://fakestoreapi.com/products"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            if error != nil || data == nil{
                print(error?.localizedDescription)
            }
            else
            {
                //bir hata yoksa zaten verilerimi alabilirim
                //verilerimi do try catch ile alabiliyorum:
                
                do{ ///yap
                    if let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]] {
                        //print(json)
                        
                        //burada json içindeki elemanların hepsini alıyorum:
                        
                        for eleman in json{
                            self.model.append(Model(title: "\(eleman["title"]!)" , image: "\(eleman["image"]!)"))
                        }
                        
                        //collectionView'i her işlem sonrasında yenilemek için, azmazsan kod çalışmaz
                        DispatchQueue.main.sync {
                            self.ProductCollectionView.reloadData()
                            }
                        
                    }
                }
                catch{ //hata varsa yakala
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
        
    }
}




extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    ///collecitonView'de kaç tane cell olacağını söyleyen fonksiyon:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.model.count
    }
    
    ///collectionView cell içindeki  görsel nesnelerin özelliklerini tanımlamamıza yarayan fonksiyondur.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ProductCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCell
        ///as! ProductCell --> ProductCell içindeki resme ve labela erişmemi sağlar. burayı eklemezsen bunlara erişemezsin.
        
        let item = model[indexPath.row]
        cell.ProductImageView.sd_setImage(with: URL(string: item.image!))
        cell.ProductLabel.text = item.title
        
        
        
        
        return cell
    }
    
    
}

