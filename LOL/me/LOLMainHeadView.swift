//
//  LOLMainHeadView.swift
//  LOL
//
//  Created by scorpio on 2016/9/29.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import Alamofire
import SwiftyJSON
import UIColor_Hex_Swift

class LOLMainHeadView: UIView {
	var headAvatarView = UIImageView()
	var headNameLabel = UILabel()
	var headDetailLabel = UILabel()
	var headRankImage = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		// 头部view上半部分
		let headTopView = UIView()
		self.addSubview(headTopView)
		headTopView.snp.makeConstraints { (make) -> Void in
			make.top.right.left.equalTo(self)
			make.height.equalTo(55)
		}
		
		// 头像
		headTopView.addSubview(self.headAvatarView)
		self.headAvatarView.backgroundColor = UIColor("#EEE")
		self.headAvatarView.layer.cornerRadius = 20
		self.headAvatarView.layer.masksToBounds = true
		self.headAvatarView.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(headTopView).offset(15)
			make.left.equalTo(headTopView).offset(15)
			make.size.equalTo(CGSize(width: 40, height: 40))
		}
		
		// 昵称
		headTopView.addSubview(headNameLabel)
		headNameLabel.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(self.headAvatarView).offset(10)
			make.left.equalTo(self.headAvatarView.snp.right).offset(10)
			make.height.equalTo(12)
			make.right.equalTo(headTopView)
		}
		headNameLabel.textColor = UIColor("#555");
		headNameLabel.text = "获取中..."
		headNameLabel.font = UIFont.systemFont(ofSize: 12)
		
		// 详细数据
		headTopView.addSubview(headDetailLabel)
		self.headDetailLabel.snp.makeConstraints { (make) -> Void in
			make.bottom.equalTo(self.headAvatarView.snp.bottom)
			make.left.equalTo(self.headAvatarView.snp.right).offset(10)
			make.height.equalTo(12)
			make.right.equalTo(headTopView)
		}
		
		// 段位icon
		headTopView.addSubview(self.headRankImage)
		self.headRankImage.snp.makeConstraints { (make) -> Void in
			make.right.equalTo(headTopView).offset(-25)
			make.top.equalTo(headTopView).offset(15)
			make.size.equalTo(CGSize(width: 48, height: 40))
		}

	}
	
	func setUinfo(avatar:String, name:String, detail:String, rank:String) -> Void {
		let url = URL(string: avatar)!
		self.headAvatarView.sd_setImage(with: url)
		
		self.headNameLabel.text = name
		
		let attrString = NSMutableAttributedString(
			string: detail,
			attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor("#8e8e8e")])
		
		let separator_range = (detail as NSString).range(of: "|")
		if(separator_range.location != NSNotFound){
			attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor("#ddd"), range: separator_range)
		}
		self.headDetailLabel.attributedText = attrString
		
		self.headRankImage.image = UIImage.init(named: rank)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
