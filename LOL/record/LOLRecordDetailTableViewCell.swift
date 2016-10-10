//
//  LOLRecordDetailTableViewCell.swift
//  LOL
//
//  Created by scorpio on 2016/10/10.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit
import UIColor_Hex_Swift
import SDWebImage

class LOLRecordDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUI(){
		self.addSubview(self.championImage)
		self.championImage.snp.makeConstraints { (make) -> Void in
			make.size.equalTo(CGSize(width: 45, height: 45))
			make.left.top.equalTo(self).offset(15)
		}
		
		self.addSubview(self.levelLabel)
		self.levelLabel.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(16)
			make.left.right.equalTo(self.championImage)
			make.top.equalTo(self.championImage.snp.bottom)
		}
		
		self.addSubview(self.userName)
		self.userName.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(15)
			make.left.equalTo(self.championImage.snp.right).offset(15)
			make.top.equalTo(self.championImage)
			make.width.equalTo(150)
		}
		
		self.addSubview(self.kdaLabel)
		self.kdaLabel.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(10)
			make.top.equalTo(self.championImage)
			make.width.equalTo(150)
			make.right.equalTo(self).offset(-15)
		}

		self.addSubview(self.eqptsView);
		self.eqptsView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(20)
			make.left.equalTo(self.userName)
			make.width.equalTo(200)
			make.bottom.equalTo(self.levelLabel.snp.bottom)
		}
		
		self.addSubview(self.damageRate)
		self.damageRate.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(13)
			make.top.equalTo(self.userName.snp.bottom).offset(7)
			make.left.equalTo(self.userName)
			make.width.equalTo(100)
		}
		
		self.addSubview(self.arrow)
		self.arrow.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(6)
			make.width.equalTo(10);
			make.right.equalTo(self).offset(-15)
			make.bottom.equalTo(self).offset(-15)
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
	
	func setDetail(championImage:String, level:String, userName:String, kda:String, eqpts:Array<String>) {
		let url = URL(string: championImage)!
		self.championImage.sd_setImage(with: url)
		
		self.levelLabel.text = "LV "+level
		self.userName.text = userName
		self.kdaLabel.text = kda
		let rate = arc4random_uniform(30 - 10) + 10
		self.damageRate.text = "   输出率:"+String(describing:rate)+"%"
		self.damageRate.snp.updateConstraints { (make) -> Void in
			make.width.equalTo(80.0+Double(rate))
		}
		self.eqptsView.setEqpts(eqpts: eqpts)
	}
	
	lazy var championImage: UIImageView = {
		let championImage = UIImageView()
		return championImage
	}()
	
	lazy var levelLabel: UILabel = {
		let levelLabel = UILabel()
		levelLabel.layer.borderColor = LOLGREEN.cgColor
		levelLabel.layer.borderWidth = 1
		levelLabel.font = UIFont.boldSystemFont(ofSize: 10)
		levelLabel.textColor = LOLGREEN
		levelLabel.textAlignment = .center
		return levelLabel
	}()
	
	lazy var userName: UILabel = {
		let userName = UILabel()
		userName.font = UIFont.systemFont(ofSize: 15)
		userName.textColor = UIColor.black
		return userName
	}()
	
	lazy var kdaLabel: UILabel = {
		let kdaLabel = UILabel()
		kdaLabel.font = UIFont.systemFont(ofSize: 10)
		kdaLabel.textColor = UIColor("#8e8e8e")
		kdaLabel.textAlignment = .right
		return kdaLabel
	}()
	
	lazy var damageRate: UILabel = {
		let damageRate = UILabel()
		damageRate.textColor = UIColor.white;
		damageRate.font = UIFont.systemFont(ofSize: 10)
		damageRate.backgroundColor = LOLRED
		damageRate.layer.masksToBounds = true
		damageRate.layer.cornerRadius = 6
		return damageRate
	}()

    lazy var eqptsView:LOLEqptView = {
        let eqptsView = LOLEqptView()
        return eqptsView
    }()
	
	lazy var arrow:UIImageView = {
		let arrow = UIImageView()
		arrow.image = UIImage.init(named: "battle_down_arrow")
		return arrow
	}()

	override func setHighlighted(_ highlighted: Bool, animated: Bool) {
		super.setHighlighted(highlighted, animated: animated)
		if(highlighted){
			self.backgroundColor = LOLCELLSELECTEDBG
		}else{
			self.backgroundColor = UIColor.white
		}
	}

}
