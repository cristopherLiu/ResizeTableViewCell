//
//  ViewController.swift
//  dynamicCell
//
//  Created by hjliu on 2016/2/25.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let tableView = UITableView()
    let datas = [
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
        Status(isShow: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //建構tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        let views = [
            "tableView" : tableView,
            ] as [String:AnyObject]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|", options: [], metrics: nil, views: views))
    }

    //大綱的活動數量
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        
        let data = datas[indexPath.row]
        
        cell.setData("\(indexPath.row + 1)",isShowButton: data.isShow, tapEvent: {
            
            data.isShow = !data.isShow //save data
            
            self.tableView.reSizeHeight()
//            self.tableView.reloadData()
//            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        })
        return cell
    }
    
}

extension UITableView{
    
    func reSizeHeight(){
        let offset = self.contentOffset
        self.beginUpdates()
        self.endUpdates()
        self.layer.removeAllAnimations()
        self.setContentOffset(offset, animated: false)
    }
}

class Status{
    var isShow:Bool
    
    init(isShow:Bool){
        self.isShow = isShow
    }
}
