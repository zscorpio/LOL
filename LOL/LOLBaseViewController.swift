//
//  LOLBaseViewController.swift
//  LOL
//
//  Created by scorpio on 2016/10/9.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit

class LOLBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//		.navigationBar.hidden = true;
		self.navigationController?.setNavigationBarHidden(true, animated: true)
		self.addNavigationBar()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: true)
	}

	func addNavigationBar(){
		self.view.addSubview(self.navigationBar)
		self.navigationBar.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(64);
			make.width.top.left.equalTo(self.view)
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	lazy var navigationBar: LOLNavigationBar = {
		let navigationBar = LOLNavigationBar.init(title: self.title!)
		return navigationBar
	}()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
