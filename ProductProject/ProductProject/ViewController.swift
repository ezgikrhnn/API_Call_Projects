//
//  ViewController.swift
//  ProductProject
//
//  Created by Ezgi Karahan on 3.01.2024.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

   
    
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    
    //navigationbar'i searchBar yapmak için tanımlama yapıyorum:
    let searchController = UISearchController()
    
    var model : [Model] = [] //jsonparse işleminden sonra boş dizimi oluşturdum, bu adımdan sonra verileri çekeceğim.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductCollectionView.delegate = self
        ProductCollectionView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        
        //aşağıdaki boyut tanımlamaları eksik olursa sağlıklı bir görüntü oluşmuyor 
        //MARK: COLLECTIONVİEW TASARIMI:
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        // 10 item 10 item 10 = toplamda yatayda 30 boşluk var
        let ekranGenisliği = UIScreen.main.bounds.width ///ekran genişliğni verir
        let itemGenislik = (ekranGenisliği - 30) / 2
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.3)
        ProductCollectionView.collectionViewLayout = tasarim
        
       
    
        
        getData(arananKelime: "")
        
    }
    
    
    func getData(arananKelime: String){
        
        //url tanımlama:
        var url = "https://dummyjson.com/products"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request){ data, response, error in //isteği gönder
            
            if error != nil || data == nil{ //hata varsa
                print(error?.localizedDescription)
                print("hata var")
            }
            else
            {
                //hata yoksa verileri al: do - try - catch
                do{
                    //JsonSerialization -> verileri işle
                    if let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] { //casting işlemi
                        //print(json)
                        
                        if let products = json["products"] as? [[String:Any]] { //süslü parantezler içine girerken çift köşeli parantezler kullanılır
                            
                            //buraya kadar her sey TAMAM
                            // şimdi verileri çekiyorum: for dngüsüyle
                            
                            //fakat fora girmeden önce images için array oluşturuyorum:
                            var imagesArray = [Images]()
                            
                            self.model.removeAll() //her bi aramada modeli temziliyorum ki veriler üst üste binmesin.
                            
                            for product in products {
                                
                                if !arananKelime.isEmpty { //eger arananKelime boş değilse
                                    if (product["title"] as? String)?.lowercased().range(of: arananKelime.lowercased()) != nil{
                                        
                                        //yukarıda tanımladıgım imageArray boş olduğu için bunu doldurmam gerekiyor: yani images datalarımı alacağım:
                                        if let imagesData = product["images"] as? [String]{
                                            var imagesArray = [Images]() //boş dizi
                                            for imageData in imagesData{
                                                imagesArray.append(Images(images: imageData))
                                            }
                                            self.model.append(Model(title: "\(product["title"]!)", thumbnail: "\(product["thumbnail"]!)"))
                                        }
                                        else{
                                           print("imagesData değeri boş")
                                        }
                                        
                                       
                                    }
                                }else{
                                    if let imagesData = product["images"] as? [String]{
                                        var imagesArray = [Images]()
                                        for imageData in imagesData {
                                            imagesArray.append(Images(images: imageData))
                                        }
                                        
                                        //boşsa:
                                        self.model.append(Model(title: "\(product["title"]!)", description: "\(product["description"]!)", price: product["price"] as? Int, thumbnail: "\(product["thumbnail"]!)", images: imagesArray )) //buradaki model yukarıdaki boş di
                                    }
                                    else{
                                        print("imagesData değeri boş görünüyor")
                                    }
                                }
                            }
                            
                            DispatchQueue.main.sync {
                                self.ProductCollectionView.reloadData() //bunu yazmazsan kod çalışmaz cünkü collectionView'i yenilemek gerekiyor.
                            }
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



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {
   //bu fonk -> searchview'e her bir harf girildiğinde filtre yapılmasını sağlayacak.
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            //eger bir sey aranmıyorsa
            return
        }
        //aranıyorsa:
        getData(arananKelime: text)
    }
    
    
    //hücre sayısı
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ProductCollectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell //casting
        let item = model[indexPath.row]   //her bir cellin idsine ulaşmış oldum.
        cell.ProductImageView.sd_setImage(with: URL(string: item.thumbnail!))
        cell.ProductImageLabel.text = item.title
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 30.0
        
        return cell
    }
    
    //hücreye tıklandıgında detay sayfasına geçiş yapacağım.
    //her hücreye tıklandıgında çalışan didSelectfonk. çağırdım:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = model[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: cell)
    }
    
    //sayfa geçişi içim gerekli olan diğer fonk: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail",
            let hedefViewController = segue.destination as? DetailsPage,
            let secilenCell = sender as? Model
        {
            //eğer secilenCell içindeki image dizisi boş değilse DetailsPage'e aktar: ama benim tam tersi oldu neden anlamadım :/
            //images boşsa döndürüyor :/
            if !secilenCell.images.isEmpty {
                let images = secilenCell.images
                hedefViewController.model = secilenCell
                hedefViewController.images = images
            }
            else{
                print("seçilen model boş")
            }
                
        }
    }
    
    
    
    
}
