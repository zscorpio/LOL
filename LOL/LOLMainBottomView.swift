//
//  LOLMainBottomView.swift
//  LOL
//
//  Created by scorpio on 2016/9/29.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit

class LOLMainBottomView: UIView {
	let allCountView = LOLDescView()
	let winRateView = LOLDescView()
	let praiseCountView = LOLDescView()
	let playAgeView = LOLDescView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let headBottomView = UIView()
		self.addSubview(headBottomView)
		headBottomView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(30);
			make.centerX.equalTo(self);
			make.top.equalTo(self);
			make.width.equalTo(320);
		}
		
		headBottomView.addSubview(allCountView)
		headBottomView.addSubview(winRateView)
		headBottomView.addSubview(praiseCountView)
		headBottomView.addSubview(playAgeView)
		
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
	}
	
	func setDetail(array:NSArray) -> Void {
		if(array.count == 4){
			allCountView.setDetail(title: (array[0] as! NSDictionary).object(forKey: "key") as! String, desc: (array[0] as! NSDictionary).object(forKey: "value") as! String)
			winRateView.setDetail(title: (array[1] as! NSDictionary).object(forKey: "key") as! String, desc: (array[1] as! NSDictionary).object(forKey: "value") as! String)
			praiseCountView.setDetail(title: (array[2] as! NSDictionary).object(forKey: "key") as! String, desc: (array[2] as! NSDictionary).object(forKey: "value") as! String)
			playAgeView.setDetail(title: (array[3] as! NSDictionary).object(forKey: "key") as! String, desc: (array[3] as! NSDictionary).object(forKey: "value") as! String)
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
