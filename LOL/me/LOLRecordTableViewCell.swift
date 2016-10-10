//
//  LOLRecordTableViewCell.swift
//  LOL
//
//  Created by scorpio on 2016/9/30.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit
import UIColor_Hex_Swift
import SDWebImage

class LOLRecordTableViewCell: UITableViewCell {

	let championImage = UIImageView()
	let gameType = UILabel()
	let gameKDA = UILabel()
	let gameResult = UILabel()
	let gameDate = UILabel()
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setUI();
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUI(){
		self.addSubview(self.championImage)
		self.championImage.layer.masksToBounds = true
		self.championImage.layer.cornerRadius = 5
		self.championImage.snp.makeConstraints { (make) -> Void in
			make.size.equalTo(CGSize(width: 35, height: 35))
			make.left.top.equalTo(self).offset(15)
		}
		
		self.addSubview(self.gameType)
		self.gameType.textColor = UIColor("#424242")
		self.gameType.font = UIFont.systemFont(ofSize: 13)
		self.gameType.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(self).offset(20)
			make.left.equalTo(self.championImage.snp.right).offset(10)
			make.height.equalTo(13)
			make.width.equalTo(50)
		}
		
		self.addSubview(self.gameKDA)
		self.gameKDA.font = UIFont.systemFont(ofSize: 10)
		self.gameKDA.snp.makeConstraints { (make) -> Void in
			make.bottom.equalTo(self).offset(-15)
			make.left.equalTo(self.championImage.snp.right).offset(10)
			make.height.equalTo(10)
			make.width.equalTo(100)
		}
		
		self.addSubview(self.gameResult)
		self.gameResult.font = UIFont.systemFont(ofSize: 8)
		self.gameResult.textColor = UIColor.white
		self.gameResult.textAlignment = NSTextAlignment.center
		self.gameResult.layer.masksToBounds = true
		self.gameResult.layer.cornerRadius = 2
		self.gameResult.snp.makeConstraints { (make) -> Void in
			make.bottom.equalTo(self.gameType.snp.bottom)
			make.left.equalTo(self.gameType.snp.right).offset(10)
			make.height.equalTo(13)
			make.width.equalTo(20)
		}
		
		self.addSubview(self.gameDate)
		self.gameDate.font = UIFont.systemFont(ofSize: 11)
		self.gameDate.textColor = UIColor("#b3b9c2")
		self.gameDate.snp.makeConstraints { (make) -> Void in
			make.centerY.equalTo(self)
			make.right.equalTo(self).offset(-20)
			make.height.equalTo(11);
			make.width.equalTo(40)
		}
		
		let bottomBorder = UILabel()
		self.addSubview(bottomBorder)
		bottomBorder.backgroundColor = LOLLINEGRAY
		bottomBorder.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self).offset(15)
			make.height.equalTo(1);
			make.right.bottom.equalTo(self)
		}
	
	}
	
	func setDetail(championImage:String,gameType:String,gameKDA:String,gameResult:Bool,gameDate:String) -> Void {
		let url = URL(string: championImage)!
		self.championImage.sd_setImage(with: url)

		self.gameType.text = gameType
		self.gameKDA.text = gameKDA
		var size = CGRect();
		size = getTextRectSize(text: gameType as NSString, font: UIFont.systemFont(ofSize: 13), size: CGSize(width: 10000, height: 13))
		self.gameType.snp.updateConstraints { (make) -> Void in
			make.width.equalTo(size.size.width)
		}
		if(gameResult){
			self.gameKDA.textColor = LOLGREEN
			self.gameResult.text = "胜利"
			self.gameResult.backgroundColor = LOLGREEN
		}else{
			self.gameKDA.textColor = LOLRED
			self.gameResult.text = "失败"
			self.gameResult.backgroundColor = LOLRED
		}
		self.gameDate.text = gameDate
		
	}

	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		if(highlighted){
			self.backgroundColor = LOLCELLSELECTEDBG
		}else{
			self.backgroundColor = UIColor.white
		}
	}
}
