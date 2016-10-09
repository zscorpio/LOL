//
//  LOLRecordViewController.swift
//  LOL
//
//  Created by scorpio on 2016/10/8.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit

class LOLRecordViewController: LOLBaseViewController {

    override func viewDidLoad() {
		self.title = "战绩详情"
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
	
	override func addNavigationBar() {
		super.addNavigationBar()
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
