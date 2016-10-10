//
//  LOLRecordDetailView.swift
//  LOL
//
//  Created by scorpio on 2016/10/10.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit

class LOLRecordDetailView: UIView {
	var textLable = UILabel()
//	var descLable = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.addSubview(self.textLable)
		self.textLable.snp.makeConstraints { (make) -> Void in
			make.left.top.bottom.equalTo(self)
			make.width.equalTo(100)
		}
	
	}
	
	func setDetail(title:String, desc:String) -> Void {
		
		let text = title + ":" + desc
		
		let attrString = NSMutableAttributedString(
			string: text,
			attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor("#8e8e8e")])
		
		let separator_range = (text as NSString).range(of: ":")
		if(separator_range.location != NSNotFound){
			attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor("#555"), range: NSMakeRange(separator_range.location+1, (text as NSString).length-separator_range.location-1))
		}
		self.textLable.attributedText = attrString
		
		var size = CGRect();
		size = getTextRectSize(text: text as NSString, font: UIFont.systemFont(ofSize: 12), size: CGSize(width: 10000, height: 12))
		self.textLable.snp.updateConstraints { (make) -> Void in
			make.width.equalTo(size.size.width)
		}
	}
	
	func setTextAlighment(center:Bool){
		self.textLable.textAlignment = .center
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
