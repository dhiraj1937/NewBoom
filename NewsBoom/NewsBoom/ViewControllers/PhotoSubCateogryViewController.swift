//
//  PhotoSubCateogryViewController.swift
//  NewsBoom
//
//  Created by Apple on 25/12/20.
//

import Foundation
class PhotoSubCateogryViewController: UIViewController {
    var listPhotos:[PhotosSubModel] = [PhotosSubModel]();
    @IBOutlet var collectionPHoto:UICollectionView!
    var catId:String = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAllPhotosByIdData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let screenWidth = collectionPHoto!.frame.size.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: screenWidth/2.1, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        collectionPHoto!.collectionViewLayout = layout
    }
}
