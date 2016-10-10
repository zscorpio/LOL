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
import MJRefresh

let RECORD_CELL_ID = "LOLRecordCell"

class LOLMeController: LOLBaseViewController, UITableViewDelegate, UITableViewDataSource{
	var tableView = UITableView()
	let headTopView = LOLMainHeadView()
	let headBottomView = LOLMainBottomView()
	var page_num = 0
	// 懒加载
	var combatList = NSMutableArray()
	
	override func viewDidLoad() {
		self.title = "战绩"
		super.viewDidLoad()
		self.view.backgroundColor = UIColor("#E8E8E8")
		
		let headView = UIView.init(frame: CGRect(x: 0, y: 64, width: Screen_Width, height: 120))
		
		headView.addSubview(headTopView)
		headTopView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(55)
			make.left.right.equalTo(headView)
			make.top.equalTo(headView);
		}
		
		headView.addSubview(headBottomView)
		headBottomView.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(30);
			make.centerX.equalTo(headView);
			make.top.equalTo(headTopView.snp.bottom).offset(15);
			make.width.equalTo(320);
		}
		
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
			make.top.equalTo(self.navigationBar.snp.bottom);
		}
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
		self.tableView.tableHeaderView = headView
		self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(LOLMeController.loadMore))
		
		tableView.register(LOLRecordTableViewCell.self, forCellReuseIdentifier: RECORD_CELL_ID)
		
		self.getUinfo()
	}

	override func addNavigationBar() {
		super.addNavigationBar()
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.1
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 65
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.combatList.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		let recordView = LOLRecordViewController()
		let dic:NSDictionary = self.combatList.object(at: indexPath.row) as! NSDictionary
		recordView.game_id = String(describing: dic.object(forKey: "game_id")!)
		self.navigationController?.pushViewController(recordView , animated: true)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:LOLRecordTableViewCell = tableView.dequeueReusableCell(withIdentifier: RECORD_CELL_ID, for: indexPath) as! LOLRecordTableViewCell
		let dic:NSDictionary = self.combatList.object(at: indexPath.row) as! NSDictionary
		let battle_time = dic.object(forKey: "battle_time") as! NSString
		let gameDate = battle_time.substring(with: NSMakeRange(5, 5))
		let gameResult = dic.object(forKey: "game_result") as! Bool
		let gameKDA = dic.object(forKey: "detail") as! NSDictionary
		let gameKDAKill = String(describing: gameKDA.object(forKey: "kill")!)
		let gameKDAAssists = String(describing: gameKDA.object(forKey: "assists")!)
		let gameKDADeath = String(describing: gameKDA.object(forKey: "death")!)
		let gameKDAString = gameKDAKill+"/"+gameKDADeath+"/"+gameKDAAssists
		cell.setDetail(championImage: dic.object(forKey: "champion_avatar") as! String, gameType: dic.object(forKey: "game_type_value") as! String, gameKDA: gameKDAString, gameResult: gameResult, gameDate: gameDate)
		cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
		cell.selectionStyle = .none;
		return cell
	}
	
	func getUinfo() -> Void {
		let gamerName = "Master丶Scorpio".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
		
		Alamofire.request(BASEURL+"lol.php?api=uinfo&name="+gamerName!).responseJSON { response in
			if(response.result.isSuccess){
				let json = JSON(response.result.value!)
				if(json["code"] == 0){
					let result:NSDictionary = json["data"].dictionaryObject! as NSDictionary
					let win_point = result["win_point"] as! NSNumber
					let area = result["area"] as! String
					let rank = result["rank"] as! String
					let detail = area+"  |  "+rank+"("+"\(win_point)"+")"

					self.headTopView.setUinfo(avatar: result["avatar"] as! String, name: result["name"] as! String, detail: detail, rank: result["rank_image"] as! String)
					
					var array = [[String:Any]]()
					
					let champion_num = result["champion_num"] as! NSNumber
					let penta_kills = result["penta_kills"] as! NSNumber
					let god_like_num = result["god_like_num"] as! NSNumber
					let total_match_mvps = result["total_match_mvps"] as! NSNumber
					
					array.append(["key":"英雄数目","value":"\(champion_num)"])
					array.append(["key":"五杀次数","value":"\(penta_kills)"])
					array.append(["key":"超神次数","value":"\(god_like_num)"])
					array.append(["key":"总MVP","value":"\(total_match_mvps)"])
					
					self.headBottomView.setDetail(array: array as NSArray);
					
					LOLUserinfo.sharedInstance.qquin = result["qquin"] as! String
					let vaid = result["vaid"] as! NSNumber
					LOLUserinfo.sharedInstance.vaid = String(describing:vaid)
					self.loadMore()
				}
			}
		}
	}
	
	func loadMore(){
		// 开始请求战绩
		let url = BASEURL+"lol.php?api=CombatList&qquin="+LOLUserinfo.sharedInstance.qquin+"&vaid="+LOLUserinfo.sharedInstance.vaid+"&p="+String(describing: self.page_num);
		Alamofire.request(url).responseJSON { response in
			if(response.result.isSuccess){
				let json = JSON(response.result.value!)
				if(json["code"] == 0){
					self.page_num+=1
//					self.combatList.addingObjects(from: (json["data"].arrayObject! as NSArray) as! [Any]) 
					self.combatList.addObjects(from: json["data"].arrayObject!)
					self.tableView.reloadData()
					self.tableView.mj_footer.endRefreshing()
				}
			}
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

