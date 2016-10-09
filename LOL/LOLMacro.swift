//
//  LOLMacro.swift
//  LOL
//
//  Created by scorpio on 2016/9/28.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import Foundation
import UIKit
import UIColor_Hex_Swift

let Screen_Width = UIScreen.main.bounds.size.width
let Screen_Height = UIScreen.main.bounds.size.height
let LOLLINEGRAY = UIColor("#e5e5e5")
let LOLBLUE = UIColor("#6ae")
let LOLCELLSELECTEDBG = UIColor("#f3f3f7")
func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
	let attributes = [NSFontAttributeName: font]
	let option = NSStringDrawingOptions.usesLineFragmentOrigin
	let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
	let real_rect  = CGRect(x: 0, y: 0, width: ceil(rect.size.width), height: ceil(rect.size.height))
	return real_rect;
}
//func RGB(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
//{
//	return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
//}
//func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor
//{
//	return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
//}
