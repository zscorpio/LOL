//
//  LOLTabBarController.swift
//  LOL
//
//  Created by scorpio on 2016/9/28.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit

class LOLTabBarController: UITabBarController {

	var tabBarArray: Array <UIViewController> = [];
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let titleArrays: Array<NSString> = ["我", "数据"]
		let normalImageArrays: Array<NSString> = ["tabbar_me", "tabbar_data"]
		let navControllers: Array<UIViewController> = [LOLMeController(), LOLDataController()];
		
		for i in 0...1 {
			setVC(navControllers[i], title: titleArrays[i], normalImage: normalImageArrays[i], selectedImage: normalImageArrays[i], tag: i + 1)
		}
		
		self.viewControllers = self.tabBarArray;
    }

	func setVC(_ vc:UIViewController, title:NSString, normalImage:NSString, selectedImage:NSString, tag:NSInteger) -> Void {
		let VC = vc;
		vc.title = title as String
		let image = UIImage.init(named: normalImage as String)
		VC.tabBarItem.selectedImage = UIImage.init(named: selectedImage as String + "_selected")
		VC.tabBarItem = UITabBarItem.init(title: title as String, image: image, tag: tag)
		self.tabBarArray.insert(VC, at: self.tabBarArray.count)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
