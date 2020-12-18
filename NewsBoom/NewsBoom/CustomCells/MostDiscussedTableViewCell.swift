//
//  MostDiscussedTableViewCell.swift
//  NewsBoom
//
//  Created by Apple on 17/12/20.
//

import UIKit

class MostDiscussedTableViewCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView!
    var listNewsModel:[NewsModel] = [NewsModel]();
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    public func SetData(_listNewsModel:[NewsModel]){
        listNewsModel = _listNewsModel;
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MostDiscussedTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return listNewsModel.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostDiscussedCollectionCell", for: indexPath) as! MostDiscussedCollectionCell
        let newModel = listNewsModel[indexPath.row];
        cell.img.imageFromServerURL(urlString: newModel.Img)
        cell.lblTitle.text = newModel.Title;
        return cell;
    }
    
    
}

extension MostDiscussedTableViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 375, height: 204)
        }
}
