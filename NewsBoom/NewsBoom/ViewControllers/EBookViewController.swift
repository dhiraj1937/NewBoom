//
//  EBookViewController.swift
//  NewsBoom
//
//  Created by Apple on 20/12/20.

import Foundation
class EBookViewController: UIViewController {
    @IBOutlet var collectionView:UICollectionView!
    var listEpaper:[EPaperModel] = [EPaperModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        GetEPaperList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let screenWidth = collectionView!.frame.size.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: screenWidth/2.1, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        collectionView!.collectionViewLayout = layout
    }
}
