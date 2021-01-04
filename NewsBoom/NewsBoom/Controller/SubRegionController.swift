//
//  SubRegionController.swift
//  NewsBoom
//
//  Created by Apple on 02/01/21.
//

import Foundation
extension SubRegionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listRegion.count == 0 {
                self.tblRegion.setEmptyMessage("No Data Found.")
            } else {
                self.tblRegion.restore()
            }

        return listRegion.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell") as! RegionTableViewCell
        cell.lbltitle.text = listRegion[indexPath.row].Title;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let region = listRegion[indexPath.row];
        if(region.child?.count==0){
            let subCategoryVC = Constant.storyboard.instantiateViewController(withIdentifier: "SubCategoryNewsViewController") as! SubCategoryNewsViewController
            subCategoryVC.catID = region.Id!;
            subCategoryVC.headerTitle = region.Title!;
            self.navigationController?.pushViewController(subCategoryVC, animated: true)
        }
        else{
            if #available(iOS 13.0, *) {
                let vc = Constant.storyboard.instantiateViewController(identifier: "SubRegionViewController") as! SubRegionViewController
                vc.listRegion = region.child!
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
                let vc = Constant.storyboard.instantiateViewController(withIdentifier: "SubRegionViewController") as! SubRegionViewController
                vc.listRegion = region.child!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
