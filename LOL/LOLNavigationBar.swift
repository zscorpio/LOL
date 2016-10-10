//
//  LOLNavigationBar.swift
//  LOL
//
//  Created by scorpio on 2016/10/9.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import SnapKit

class LOLNavigationBar: UIView {
	typealias block = () ->()
	var goBack:block!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	convenience init(title: String) {
		self.init(frame: CGRect.zero)
		self.titleLabel.text = title
		self.backgroundColor = UIColor("#F8F8F8")
		self.addSubview(self.titleLabel)
		self.addSubview(self.line)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		self.titleLabel.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(17);
			make.width.equalTo(Screen_Width-2*100)
			make.centerX.equalTo(self)
			make.centerY.equalTo(self).offset(10)
		}
		
		self.line.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(0.5);
			make.width.left.bottom.equalTo(self)
		}
		
		super.layoutSubviews()
	}
	
	func showBack(show:Bool){
		self.addSubview(self.backButton)
		self.backButton.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(self).offset(20)
			make.bottom.left.equalTo(self)
			make.width.equalTo(100)
		}
		self.backButton.isHidden = !show
	}
	
	func setBackTitle(title:String){
		self.backButton.setTitle(title, for: .normal)
	}
	
	func clickBack(){
		if ((self.goBack) != nil) {
			self.goBack();
		}
	}
	
	lazy var titleLabel: UILabel = {
		let titleLabel = UILabel()
		titleLabel.font = UIFont.systemFont(ofSize: 17)
		titleLabel.textAlignment = NSTextAlignment.center
		titleLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
		return titleLabel
	}()

	lazy var line: UIView = {
		let line = UIView()
		line.backgroundColor = UIColor("#ccc")
		return line
	}()

	lazy var backButton: UIButton = {
		let backButton = UIButton(type: .custom)
		backButton.contentHorizontalAlignment = .left
		let back_image = UIImage(named: "back")
		backButton.setImage(back_image!, for: .normal)
		backButton.addTarget(self, action: #selector(self.clickBack), for: .touchUpInside)
		backButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40)
		backButton.titleLabel!.font = UIFont.systemFont(ofSize: 16)
		backButton.setTitleColor(LOLBLUE, for: .normal)
		backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
		return backButton
	}()
}
