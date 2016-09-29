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

let RECORD_CELL_ID = "LOLRecordCell"

class LOLMeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
	var tableView = UITableView()
	let headTopView = LOLMainHeadView()
	// 懒加载
	lazy var datas: [Int] = {
		// 创建一个存放int的数组
		var nums = [Int]()
		// 添加数据
		for i in 0...50 {
			nums.append(i)
		}
		// 返回
		return nums
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor("#E8E8E8")
		
		let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: 130))
//		self.view.addSubview(headView)
//		headView.snp.makeConstraints { (make) -> Void in
//			make.height.equalTo(115)
//			make.left.right.equalTo(self.view)
//			make.top.equalTo(self.view).offset(64);
//		}
//		headView.backgroundColor = UIColor.gray
		
		headView.addSubview(headTopView)
		headTopView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(55)
			make.left.right.equalTo(headView)
			make.top.equalTo(headView);
		}
		
		let headBottomView = LOLMainBottomView()
		headView.addSubview(headBottomView)
		headBottomView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(30);
			make.centerX.equalTo(headView);
			make.top.equalTo(headTopView.snp.bottom).offset(15);
			make.width.equalTo(320);
		}
		
		var array = [[String:Any]]()
		
		array.append(["key":"总场数","value":"4650"])
		array.append(["key":"胜率","value":"55%"])
		array.append(["key":"获赞","value":"256次"])
		array.append(["key":"游戏年龄","value":"3.5年"])

		headBottomView.setDetail(array: array as NSArray);
		
		let headBottomSeparator = UIView()
		headView.addSubview(headBottomSeparator)
		headBottomSeparator.backgroundColor = UIColor("#f2f2f2")
		headBottomSeparator.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(10);
			make.left.right.equalTo(headView);
			make.top.equalTo(headBottomView.snp.bottom).offset(15);
		}

		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) -> Void in
			make.left.right.bottom.equalTo(self.view)
			make.top.equalTo(self.view).offset(0);
		}
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.tableHeaderView = headView
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: RECORD_CELL_ID)
		
		self.getUinfo()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: RECORD_CELL_ID, for: indexPath) 
		cell.textLabel!.text = "假数据 - \(datas[indexPath.row])"
		return cell
	}
	
	func getUinfo() -> Void {
		let headers: HTTPHeaders = [
			"DAIWAN-API-TOKEN": "8FF05-E5EFE-A7583-23432"
		]
		
		let gamerName = "Master丶Scorpio".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
		
		Alamofire.request("http://lolapi.games-cube.com/UserArea?keyword="+gamerName!, headers: headers).responseJSON { response in
			if(response.result.isSuccess){
				let json = JSON(response.result.value!)
				print(json["code"])
				if(json["code"] == 0){
					var result: NSArray = []
					result = json["data"].arrayObject! as NSArray
					let first_data = result[0] as! NSDictionary
					let icon_id = first_data["icon_id"] as! NSNumber
					let icon_id_string = "\(icon_id)"
					let area = self.getAreaById(id: first_data["area_id"] as! NSInteger)
					let rankDic = self.getRank(tier: first_data["tier"] as! NSInteger, queue: first_data["queue"] as! NSInteger)
					let win_point = first_data["win_point"] as! NSNumber
					let detail = area+"  |  "+rankDic["rank"]!+"("+"\(win_point)"+")"
					self.headTopView.setUinfo(avatar: "http://ddragon.leagueoflegends.com/cdn/6.18.1/img/profileicon/"+icon_id_string+".png", name: first_data["name"] as! String, detail: detail, rank: rankDic["image"]!)
				}
			}
		}
	}
	
	func getRank(tier:NSInteger, queue:NSInteger) -> [String:String] {
		let tierArray = ["最强王者","钻石","铂金","黄金","白银","青铜"]
		let imageArray = ["Challenger","Diamond","Platinum","Gold","Silver","Bronze"]
		let queueArray = ["I","II","III","IⅤ","V"]
		if(tier == 255 && queue == 255){
			return ["rank":"无段位","image":"NoRank"]
		}
		return ["rank":tierArray[tier]+queueArray[queue],"image":imageArray[queue]]
	}
	
	func getAreaById(id:NSInteger) -> String {
		let areaArray = ["艾欧尼亚","比尔吉沃特","祖安","诺克萨斯","班德尔城","德玛西亚","皮尔特沃夫","战争学院","弗雷尔卓德","巨神峰","雷瑟守备","无畏先锋","裁决之地","黑色玫瑰","暗影岛","恕瑞玛","钢铁烈阳","水晶之痕","均衡教派","扭曲丛林","教育网专区","影流","守望之海","征服之海","卡拉曼达","巨龙之巢","皮城警备"]
		return areaArray[id-1]
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

