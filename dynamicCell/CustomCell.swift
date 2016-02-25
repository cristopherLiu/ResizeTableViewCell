//
//  CustomCell.swift
//  dynamicCell
//
//  Created by hjliu on 2016/2/25.
//  Copyright © 2016年 hjliu. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    private let BGView = UIView()
    private let titleLabel = UILabel()
    private let button = UIButton()
    
    /// DATA
    var chceckEvent:(()->())? //點擊event
    var isShowButton:Bool = false{
        didSet{
            button.hidden = isShowButton == false
            setNeedsUpdateConstraints()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        
        BGView.layer.cornerRadius = 8
        BGView.clipsToBounds = true
        BGView.backgroundColor = UIColor.lightGrayColor()
        BGView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(BGView)
        
        titleLabel.font = UIFont.systemFontOfSize(16.0)
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        BGView.addSubview(titleLabel)
        
        button.setTitle("按鈕", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.backgroundColor = UIColor.redColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.None
        
        //點擊手勢
        let tap1 = UITapGestureRecognizer(target: self, action: "tapGesture")
        tap1.numberOfTapsRequired = 1
        BGView.addGestureRecognizer(tap1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var showDateConstraints1:[NSLayoutConstraint] = []
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if showDateConstraints1.count > 0{
            contentView.removeConstraints(showDateConstraints1)
        }
        
        let viewsDict = [
            "BGView":BGView,
            "titleLabel":titleLabel,
            "button":button,
            ] as [String:AnyObject]
        
        if isShowButton{
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[BGView]-|", options: [], metrics: nil, views: viewsDict))
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[button]-|", options: [], metrics: nil, views: viewsDict))
            showDateConstraints1 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[BGView(100@500)][button(50@500)]-|", options: [], metrics: nil, views: viewsDict)
            contentView.addConstraints(showDateConstraints1)
            
        }else{
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[BGView]-|", options: [], metrics: nil, views: viewsDict))
            showDateConstraints1 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[BGView(100@500)]-|", options: [], metrics: nil, views: viewsDict)
            contentView.addConstraints(showDateConstraints1)
        }
        
        BGView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[BGView]-(<=0)-[titleLabel]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: viewsDict))
        BGView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[BGView]-(<=0)-[titleLabel]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: viewsDict))
    }
    
    func setData(text:String, isShowButton:Bool, tapEvent:()->()){
        titleLabel.text = text
        self.chceckEvent = tapEvent
        self.isShowButton = isShowButton
    }
    
    func tapGesture(){
        isShowButton = !isShowButton
        chceckEvent?()
    }
}
