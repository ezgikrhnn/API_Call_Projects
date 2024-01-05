//
//  DetailsPage.swift
//  ProductProject
//
//  Created by Ezgi Karahan on 4.01.2024.
//

import UIKit

class DetailsPage: UIViewController {

    @IBOutlet weak var ThumbnailsCollectionView: UICollectionView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    var model : Model?
    var images : [Images]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //model title navbarda göster
        self.title = model?.title
        DescriptionLabel.text = model?.description
        
        //price int oldugu için onu direkt alamıyorum
        if let price = model?.price{
            PriceLabel.text = String(price) + " ₺"
            
            ThumbnailsCollectionView.delegate = self
            ThumbnailsCollectionView.dataSource = self
            
            
            
            let tasarimGenel = UICollectionViewFlowLayout()
            let ekranYukseklik = UIScreen.main.bounds.height
          
            
            tasarimGenel.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            tasarimGenel.minimumLineSpacing = 0
            tasarimGenel.minimumInteritemSpacing = 0
            tasarimGenel.scrollDirection = .horizontal
            
            let itemYukseklikGenel = ekranYukseklik / 5
            
            tasarimGenel.itemSize = CGSize(width: 393, height: itemYukseklikGenel*1.3)
            ThumbnailsCollectionView.collectionViewLayout = tasarimGenel
           
        }
    }
}


extension DetailsPage : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ThumbnailsCollectionView.dequeueReusableCell(withReuseIdentifier: "thumbnailsCell", for: indexPath) as! ThumbnailsCell //casting
        
        if let imagesURLString = images?[indexPath.row].images,
           let imageURL = URL(string: imagesURLString){
            cell.ThumbnailsImageView.sd_setImage(with: imageURL)
        }
        
       
        
        
        return cell
    }
    
    
    
}
