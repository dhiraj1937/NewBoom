//
//  VideoController.swift
//  NewsBoom
//
//  Created by Apple on 25/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension VideosCategoryViewController
:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listVideos.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let photoModel = listVideos[indexPath.row]
        cell.SetData(videoModel: photoModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let epaperModel = listVideos[indexPath.row]
        
        if #available(iOS 13.0, *) {
            let vc = Constant.storyboard.instantiateViewController(identifier: "VideoSubcategoryViewController") as VideoSubcategoryViewController
            vc.catId = epaperModel.Id;
            Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = Constant.storyboard.instantiateViewController(withIdentifier: "VideoSubcategoryViewController") as! VideoSubcategoryViewController
            vc.catId = epaperModel.Id;
            Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    func GetAllVideosData(){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getVideoCategoryUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                self.listVideos = try! JSONDecoder().decode([VideosModel].self, from: jsonData!)
                self.collectionPHoto.reloadData()
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
        }, failure: { (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
    }
    
    
}


extension VideoSubcategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listVideos.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let photoModel = listVideos[indexPath.row]
        cell.SetData(videoModel: photoModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let epaperModel = listVideos[indexPath.row]
        if #available(iOS 13.0, *) {
            let vc = Constant.storyboard.instantiateViewController(identifier: "FileViewerViewController") as FileViewerViewController
            vc.fileURL = epaperModel.Video;
            vc.headerTitle = epaperModel.Title;
            Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = Constant.storyboard.instantiateViewController(withIdentifier: "FileViewerViewController") as! FileViewerViewController
            vc.fileURL = epaperModel.Video;
            vc.headerTitle = epaperModel.Title;
            Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    
    func GetAllVideoByIdData(){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getVideosByCategoryUrl+"/"+self.catId.description, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                self.listVideos = try! JSONDecoder().decode([VideoSubModel].self, from: jsonData!)
                self.collectionPHoto.reloadData()
            }
            else{
                self.ShowAlertMessage(message:msg!.description , vc: self,title:"Failed",bannerStyle: BannerStyle.danger)
            }
            self.removeSpinner(onView: self.view)
        }, failure: { (Error) in
            self.ShowAlertMessage(message: Error.localizedDescription, vc: self,title:"Error",bannerStyle: BannerStyle.danger)
            self.removeSpinner(onView: self.view)
        })
        
    }
}
