//
//  ViewController.swift
//  BasicNewsAppProject
//
//  Created by Ezgi Karahan on 7.01.2024.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var NewsTAbleView: UITableView!
    var model : [Model] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
       
        NewsTAbleView.dataSource = self
        NewsTAbleView.delegate = self
        
    }

    func getData() {
        //webservices sınıfını burada kullanıyorum.
        WebServices.shared.fetchData { model in
            
            //öncelikle yukarıdaki boş diziyi doldurmam gerekiyor.
            if let model = model {
                
                DispatchQueue.main.async {
                    self.model = model
                    self.NewsTAbleView.reloadData()//yazmazsan kod çalışmaz 
                }
            }
            else{
                print("veri gelmedi")
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsTAbleView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        
        let item = model[indexPath.row]
        cell.newsDescriptionLabel.text = item.description
        cell.newsTitleLabel.text = item.title
        cell.newsImageView.sd_setImage(with: URL(string: item.urlToImage ?? "NIL")) //eğer veri gelmiyosa nil göster dedim.
        return cell
    }
    
    
    
}

