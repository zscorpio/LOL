//
//  LOLUserinfo.swift
//  LOL
//
//  Created by scorpio on 2016/10/10.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit

class LOLUserinfo: NSObject{
	static let sharedInstance = LOLUserinfo()
	var qquin:String
	var vaid:String
	override init() {
		self.qquin = ""
		self.vaid = ""
	}
}
