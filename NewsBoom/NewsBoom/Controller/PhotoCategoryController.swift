//
//  PhotoCategoryController.swift
//  NewsBoom
//
//  Created by Apple on 25/12/20.
//

import Foundation
import NotificationBannerSwift
import SwiftyJSON
extension PhotosCategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listPhotos.count == 0 {
                self.collectionPHoto.setEmptyMessage("No Data Found.")
            } else {
                self.collectionPHoto.restore()
            }
        return listPhotos.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let photoModel = listPhotos[indexPath.row]
        cell.SetData(photModel: photoModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let epaperModel = listPhotos[indexPath.row]
        if(epaperModel.Count>0){
            if #available(iOS 13.0, *) {
                let vc = Constant.storyboard.instantiateViewController(identifier: "PhotoSubCateogryViewController") as PhotoSubCateogryViewController
                vc.catId = epaperModel.Id;
                Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = Constant.storyboard.instantiateViewController(withIdentifier: "PhotoSubCateogryViewController") as! PhotoSubCateogryViewController
                vc.catId = epaperModel.Id;
                Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
            }
           
           
        }
        else{
            
        }
    }
    
    func GetAllPhotosData(){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getPhotoCategoryUrl, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                self.listPhotos = try! JSONDecoder().decode([PhotosModel].self, from: jsonData!)
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
extension PhotoSubCateogryViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listPhotos.count == 0 {
                self.collectionPHoto.setEmptyMessage("No Data Found.")
            } else {
                self.collectionPHoto.restore()
            }

        return listPhotos.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let photoModel = listPhotos[indexPath.row]
        cell.SetData(photSubModel: photoModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let epaperModel = listPhotos[indexPath.row]
        if #available(iOS 13.0, *) {
            let vc = Constant.storyboard.instantiateViewController(identifier: "FileViewerViewController") as FileViewerViewController
            vc.fileURL = epaperModel.Photo;
            vc.headerTitle = epaperModel.ShortDescimg;
            Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
            let vc = Constant.storyboard.instantiateViewController(withIdentifier: "FileViewerViewController") as! FileViewerViewController
            vc.fileURL = epaperModel.Photo;
            vc.headerTitle = epaperModel.ShortDescimg;
            Constant.GetCurrentVC().navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    
    func GetAllPhotosByIdData(){
        self.showSpinner(onView: self.view)
        ApiManager.sharedInstance.requestGETURL(Constant.getPhotosByCategoryUrl+"/"+self.catId.description, success: { [self]
            (JSON) in
            let msg =  JSON.dictionary?["Message"]
            if((JSON.dictionary?["IsSuccess"]) != false){
                let jsonData =  JSON.dictionary?["ResponseData"]!.rawString()!.data(using: .utf8)
                self.listPhotos = try! JSONDecoder().decode([PhotosSubModel].self, from: jsonData!)
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
