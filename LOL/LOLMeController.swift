//
//  LOLMeController.swift
//  LOL
//
//  Created by scorpio on 2016/9/28.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import Alamofire
import SwiftyJSON
import UIColor_Hex_Swift

class LOLMeController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor("#E8E8E8")
		
		let headView = UIView()
		self.view.addSubview(headView)
		headView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(115)
			make.left.right.equalTo(self.view)
			make.top.equalTo(self.view).offset(64);
		}
		headView.backgroundColor = UIColor.white
		
		let headTopView = LOLMainHeadView()
		headView.addSubview(headTopView)
		headTopView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(115)
			make.left.right.equalTo(self.view)
			make.top.equalTo(self.view).offset(64);
		}
		headTopView.setUinfo(avatar: "http://ddragon.leagueoflegends.com/cdn/6.18.1/img/profileicon/1.png", name: "Master丶Scorpio", detail: "守望之海  |  铂金III(0)", rank: "Challenger")
		
//
//		
//		let headAvatarView = UIImageView()
//		headView.addSubview(headAvatarView)
//		headAvatarView.backgroundColor = UIColor("#EEE")
//		headAvatarView.layer.cornerRadius = 20
//		headAvatarView.layer.masksToBounds = true
//		headAvatarView.snp.makeConstraints { (make) -> Void in
//			make.top.equalTo(headView).offset(15)
//			make.left.equalTo(headView).offset(15)
//			make.size.equalTo(CGSize(width: 40, height: 40))
//		}
//		
//		let headNameLabel = UILabel()
//		headView.addSubview(headNameLabel)
//		headNameLabel.snp.makeConstraints { (make) -> Void in
//			make.top.equalTo(headAvatarView).offset(10)
//			make.left.equalTo(headAvatarView.snp.right).offset(10)
//			make.height.equalTo(12)
//			make.right.equalTo(headView)
//		}
//		headNameLabel.textColor = UIColor("#555");
//		headNameLabel.text = "未知"
//		headNameLabel.font = UIFont.systemFont(ofSize: 12)
//		
//		let headDetailLabel = UILabel()
//		headView.addSubview(headDetailLabel)
//		headDetailLabel.snp.makeConstraints { (make) -> Void in
//			make.bottom.equalTo(headAvatarView.snp.bottom)
//			make.left.equalTo(headAvatarView.snp.right).offset(10)
//			make.height.equalTo(12)
//			make.right.equalTo(headView)
//		}
//		
//		let detailString:NSString = "守望之海  |  铂金III(0)"
//		let headDetailLabelString = NSMutableAttributedString(
//			string: detailString as String,
//			attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor("#8e8e8e")])
//		
//		let separator_range = detailString.range(of: "|")
//		if(separator_range.location != NSNotFound){
//			headDetailLabelString.addAttribute(NSForegroundColorAttributeName, value: UIColor("#ddd"), range: separator_range)
//		}
//		headDetailLabel.attributedText = headDetailLabelString
//		
//		let headRankImage = UIImageView()
//		headView.addSubview(headRankImage)
//		headRankImage.image = UIImage.init(named: "Challenger")
//		headRankImage.snp.makeConstraints { (make) -> Void in
//			make.right.equalTo(headView).offset(-25)
//			make.top.equalTo(headView).offset(15)
//			make.size.equalTo(CGSize(width: 48, height: 40))
//		}
//		
		let headBottomView = UIView()
		self.view.addSubview(headBottomView)
		headBottomView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(30);
			make.centerX.equalTo(headView);
			make.top.equalTo(headTopView.snp.bottom).offset(15);
			make.width.equalTo(320);
		}
		
		let allCountView = LOLDescView()
		headBottomView.addSubview(allCountView)
		allCountView.setDetail(title: "4650", desc: "总场数")
		
		let winRateView = LOLDescView()
		headBottomView.addSubview(winRateView)
		winRateView.setDetail(title: "55%", desc: "胜率")
		
		let praiseCountView = LOLDescView()
		headBottomView.addSubview(praiseCountView)
		praiseCountView.setDetail(title: "256次", desc: "获赞")
		
		let playAgeView = LOLDescView()
		headBottomView.addSubview(playAgeView)
		playAgeView.setDetail(title: "3.5年", desc: "游戏年龄")
		playAgeView.setBorderHidden(hidden: true)
		
		allCountView.snp.makeConstraints { (make) -> Void in
			make.centerY.equalTo(headBottomView)
			make.size.equalTo(CGSize(width: 80, height: 30))
			make.left.equalTo(headBottomView)
		}
		
		winRateView.snp.makeConstraints { (make) -> Void in
			make.centerY.equalTo(headBottomView)
			make.size.equalTo(CGSize(width: 80, height: 30))
			make.left.equalTo(allCountView.snp.right)
		}
		
		praiseCountView.snp.makeConstraints { (make) -> Void in
			make.centerY.equalTo(headBottomView)
			make.size.equalTo(CGSize(width: 80, height: 30))
			make.left.equalTo(winRateView.snp.right)
		}
		
		playAgeView.snp.makeConstraints { (make) -> Void in
			make.centerY.equalTo(headBottomView)
			make.size.equalTo(CGSize(width: 80, height: 30))
			make.left.equalTo(praiseCountView.snp.right)
		}
		
		
//		let headers: HTTPHeaders = [
//			"DAIWAN-API-TOKEN": "8FF05-E5EFE-A7583-23432"
//		]
//		
//		let gamerName = "Master丶Scorpio".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//		
//		Alamofire.request("http://lolapi.games-cube.com/UserArea?keyword="+gamerName!, headers: headers).responseJSON { response in
//			if(response.result.isSuccess){
//				let json = JSON(response.result.value!)
//				print(json["code"])
//				if(json["code"] == 0){
//					var result: NSArray = []
//					result = json["data"].arrayObject! as NSArray
//					let first_data = result[0] as! NSDictionary
//					let icon_id = first_data["icon_id"] as! NSNumber
//					let icon_id_string = "\(icon_id)"
//					let url = URL(string: "http://ddragon.leagueoflegends.com/cdn/6.18.1/img/profileicon/"+icon_id_string+".png")!
//					headAvatarView.sd_setImage(with: url)
//					
//					headNameLabel.text = first_data["name"] as? String
//				}
//			}
//		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

