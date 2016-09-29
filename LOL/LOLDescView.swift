//
//  LOLDescView.swift
//  LOL
//
//  Created by scorpio on 2016/9/29.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit
import UIColor_Hex_Swift

class LOLDescView: UIView {
	var titleLable = UILabel()
	var descLable = UILabel()
	var rightBorder = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.addSubview(self.titleLable)
		self.titleLable.font = UIFont.systemFont(ofSize: 12);
		self.titleLable.textColor = UIColor("#555")
		self.titleLable.snp.makeConstraints { (make) -> Void in
			make.centerX.equalTo(self)
			make.top.equalTo(self)
			make.height.equalTo(12);
		}
		
		self.addSubview(self.descLable)
		self.descLable.font = UIFont.systemFont(ofSize: 11);
		self.descLable.textColor = UIColor("#8e8e8e")
		self.descLable.snp.makeConstraints { (make) -> Void in
			make.centerX.equalTo(self)
			make.top.equalTo(self.titleLable.snp.bottom).offset(10)
			make.height.equalTo(11);
		}
		
		self.addSubview(self.rightBorder)
		self.rightBorder.backgroundColor = UIColor("#ddd")
		self.rightBorder.snp.makeConstraints { (make) -> Void in
			make.centerY.equalTo(self)
			make.right.equalTo(self.snp.right)
			make.width.equalTo(1)
			make.height.equalTo(25)
		}
	}
	
	func setBorderHidden(hidden:Bool) -> Void {
		self.rightBorder.isHidden = true
	}
	
	func setDetail(title:String, desc:String) -> Void {
		self.titleLable.text = title
		self.descLable.text = desc
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
