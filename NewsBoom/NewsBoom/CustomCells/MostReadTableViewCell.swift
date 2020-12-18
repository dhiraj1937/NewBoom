//
//  MostReadTableViewCell.swift
//  NewsBoom
//
//  Created by Apple on 17/12/20.
//

import UIKit

class MostReadTableViewCell: UITableViewCell {
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
extension MostReadTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return listNewsModel.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostReadNewCollectionViewCell", for: indexPath) as! MostReadNewCollectionViewCell
        let newModel = listNewsModel[indexPath.row];
        cell.icon.imageFromServerURL(urlString: newModel.Img)
        cell.lblTilte.text = newModel.Title;
        cell.lblCount.text = newModel.Views;
        cell.lbldate.text = newModel.DateTime
        return cell;
    }
    
    
}

extension MostReadTableViewCell:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 375, height: 230)
        }
}
