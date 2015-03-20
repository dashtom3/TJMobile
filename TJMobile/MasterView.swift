//
//  MasterView.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/18.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit
protocol MasterViewDelegate:NSObjectProtocol{
    func showLeftView()
    func pushViewController(num:Int)
}
class MasterView: UIView, UICollectionViewDataSource,UICollectionViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    var delegate:MasterViewDelegate?

    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var searchImage: UIImageView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib(){
         collectionView.backgroundColor = UIColor.clearColor()
         collectionView.registerNib(UINib(nibName:"MasterCollectionViewCell",bundle:nil),forCellWithReuseIdentifier:"MasterCell")
        searchImage.image = UIImage(named: "master_search")?.resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: UIImageResizingMode.Stretch)
    }
    @IBAction func showLeftView(sender: AnyObject) {
        delegate?.showLeftView()
    }
    @IBAction func searchEnd(sender: AnyObject) {
        self.searchItemShow(search.text)
    }
    @IBAction func searchChanged(sender: AnyObject) {
        self.searchItemShow(search.text)
    }
    @IBAction func searchExit(sender: AnyObject) {
        self.searchItemShow(search.text)
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        search.resignFirstResponder()
    }
    func searchItemShow(searchString:NSString){
        if(searchString==""){
            for(var i=0;i<cards.count;i++){
                if(cards[i].visable != 2 ){
                    cards[i].visable = 1
                }
            }
        }else{
            for(var i=0;i<cards.count;i++){
                if(cards[i].visable != 2){
                    if(cards[i].labelName.rangeOfString(searchString).location == NSNotFound){
                        cards[i].visable = 0
                    }else{
                        cards[i].visable = 1
                    }
                }
            }
        }
        collectionView.reloadData()
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func refresh(){
        collectionView.reloadData()
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView .dequeueReusableCellWithReuseIdentifier("MasterCell", forIndexPath: indexPath) as MasterCollectionViewCell
        cell.setStyle(indexPath.row)
        return cell
    }
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(cards[indexPath.row].visable != 2){
            return true
        }
        return false
    }
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        //collectionView.performBatchUpdates(nil, completion: nil)
        collectionView.scrollEnabled = true
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //collectionView.performBatchUpdates(nil, completion: nil)
        collectionView.scrollEnabled = true
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        for(var i = 0;i < collectionView.numberOfItemsInSection(0);i++){
            if(i == indexPath.row){
                var cell = collectionView.cellForItemAtIndexPath(indexPath) as MasterCollectionViewCell
                cell.alpha = 0.5
            }else if(cards[i].visable == 1){
                var cell = collectionView .cellForItemAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as MasterCollectionViewCell
                cell.alpha = 1
            }else if(cards[i].visable == 0){
                var cell = collectionView .cellForItemAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as MasterCollectionViewCell
                cell.alpha = 0.5
            }
        }
        delegate?.pushViewController(indexPath.row)
        
    }

}
