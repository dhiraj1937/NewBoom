//
//  EPaperController.swift
//  NewsBoom
//
//  Created by Apple on 20/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension EBookViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listEpaper.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EBookCollectionCell", for: indexPath) as! EBookCollectionCell
        let epaperModel = listEpaper[indexPath.row]
        cell.SetData(epaperModel: epaperModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let epaperModel = listEpaper[indexPath.row]
        let vc = Constant.storyboard.instantiateViewController(identifier: "FileViewerViewController") as FileViewerViewController
        vc.fileURL = epaperModel.Epaper;
        vc.headerTitle = epaperModel.Title;
        Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func GetEPaperList(){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getEpaperUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                listEpaper = try! JSONDecoder().decode([EPaperModel].self, from: jsonData!)
                collectionView.reloadData()
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
           
        }, failure: { [self] (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
           
        })
    }
}
