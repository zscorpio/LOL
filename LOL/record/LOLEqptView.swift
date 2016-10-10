//
//  LOLEqptView.swift
//  LOL
//
//  Created by scorpio on 2016/10/10.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit
import UIColor_Hex_Swift
import SDWebImage

class LOLEqptView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setEqpts(eqpts:Array<String>) {
		for view in self.subviews {
			view.removeFromSuperview()
		}
		for (index, eqpt) in eqpts.enumerated() {
			let image = UIImageView.init(frame: CGRect.init(x: index*25, y: 0, width: 20, height: 20))
			self.addSubview(image);
			let url = URL(string: eqpt)!
			image.sd_setImage(with: url)
		}
	}
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
