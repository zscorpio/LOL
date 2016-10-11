//
//  LOLRecordViewController.swift
//  LOL
//
//  Created by scorpio on 2016/10/8.
//  Copyright © 2016年 Scorpio. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import Alamofire
import SwiftyJSON
import UIColor_Hex_Swift

let RECORD_DETAIL_CELL_ID = "LOLRecordDetailCell"
let RECORD_BASE_CELL_ID = "LOLRecordBaseCell"

class LOLRecordViewController: LOLBaseViewController, UITableViewDelegate, UITableViewDataSource {
	var game_id:String = ""
	var tableView = UITableView()
	var gameDetail = Array(Dictionary<String, AnyObject>())

    override func viewDidLoad() {
		self.title = "战绩详情"
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		
		self.view.addSubview(self.tableView)
		self.tableView.snp.makeConstraints { (make) -> Void in
			make.left.right.bottom.equalTo(self.view)
			make.top.equalTo(self.navigationBar.snp.bottom);
		}
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
		self.tableView.tableHeaderView = self.headView
		self.tableView.backgroundColor = UIColor.white
		
		tableView.register(LOLRecordDetailTableViewCell.self, forCellReuseIdentifier: RECORD_DETAIL_CELL_ID)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: RECORD_BASE_CELL_ID)
		
		self.getGameDetail();
    }
	
	func getGameDetail() -> Void {
		// 开始请求战绩详情
		let url = BASEURL+"lol.php?api=gameDetail&qquin="+LOLUserinfo.sharedInstance.qquin+"&vaid="+LOLUserinfo.sharedInstance.vaid+"&game_id="+self.game_id
		Alamofire.request(url).responseJSON { response in
			if(response.result.isSuccess){
				let json = JSON(response.result.value!)
				if(json["code"] == 0){
					let result:NSDictionary = json["data"].dictionaryObject! as NSDictionary
					let date = result["start_time"] as! NSString
					let show_date = date.substring(with: NSMakeRange(11, 5))
					let time = (result["duration"] as! Int)/60
					let type = result["game_type_value"] as! String
					self.updateHeadView(date: show_date, time: String(describing:time)+"分钟", type: type)
					self.gameDetail = NSMutableArray(array:(result["team"] as! NSArray))
					self.tableView.reloadData()
				}
			}
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return self.gameDetail.count
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 35
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let sectionHeadView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_Width, height: 35))
		sectionHeadView.backgroundColor = LOLCELLBG
		
		let leftResultLabel = UILabel()
		sectionHeadView.addSubview(leftResultLabel)
		leftResultLabel.snp.makeConstraints { (make) -> Void in
			make.left.bottom.equalTo(sectionHeadView)
			make.width.equalTo(60)
			make.height.equalTo(20)
		}
		leftResultLabel.font = UIFont.systemFont(ofSize: 12)
		leftResultLabel.textColor = UIColor.white
		leftResultLabel.textAlignment = .center
		
		let rightResultLabel = UILabel()
		sectionHeadView.addSubview(rightResultLabel)
		rightResultLabel.snp.makeConstraints { (make) -> Void in
			make.right.equalTo(sectionHeadView.snp.right).offset(-10)
			make.left.top.bottom.equalTo(sectionHeadView)
		}
		rightResultLabel.text = "杀73死61助攻47钱100000"
		rightResultLabel.font = UIFont.systemFont(ofSize: 10)
		rightResultLabel.textAlignment = .right
		
		if(section == 0){
			leftResultLabel.backgroundColor = LOLGREEN
			leftResultLabel.text = "胜利方"
			rightResultLabel.textColor = LOLGREEN
		}else{
			leftResultLabel.backgroundColor = LOLRED
			leftResultLabel.text = "失败方"
			rightResultLabel.textColor = LOLRED
		}

		return sectionHeadView
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 105
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if(self.gameDetail.count == 2){
			return (self.gameDetail[section] as! NSArray).count
		}else{
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.tableView.deselectRow(at: indexPath, animated: true)
		let dic:NSDictionary = ["type" : "detail"]
		(self.gameDetail[indexPath.section] as AnyObject).add(dic)
		
		self.tableView.beginUpdates()
		let new_indexPath = IndexPath.init(row: indexPath.row, section: indexPath.section)
		self.tableView.insertRows(at: [new_indexPath], with: .automatic)
		self.tableView.endUpdates()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if(self.gameDetail.count == 2){
			let dic = (self.gameDetail[indexPath.section] as! NSArray)[indexPath.row] as! NSDictionary
			let type = String(describing: dic["type"]!)
			if(type == "profile"){
				let recordCell = tableView.dequeueReusableCell(withIdentifier: RECORD_DETAIL_CELL_ID, for: indexPath) as! LOLRecordDetailTableViewCell
				let champion_id = String(describing: dic["champion_id"]!)
				let level = String(describing: dic["level"]!)
				let gameKDAKill = String(describing: dic["champions_killed"]!)
				let gameKDAAssists = String(describing: dic["assists"]!)
				let gameKDADeath = String(describing: dic["num_deaths"]!)
				let gameKDAString = gameKDAKill+"/"+gameKDADeath+"/"+gameKDAAssists
				let eqpts:Array<String> = [
					String(describing: dic["item0"]!),
					String(describing: dic["item1"]!),
					String(describing: dic["item2"]!),
					String(describing: dic["item3"]!),
					String(describing: dic["item4"]!),
					String(describing: dic["item5"]!),
					String(describing: dic["item6"]!),
				]
				recordCell.setDetail(championImage: "http://cdn.tgp.qq.com/pallas/images/champions_id/"+champion_id+".png", level: level, userName: dic["name"] as! String, kda: gameKDAString, eqpts: eqpts)
				recordCell.selectionStyle = .none;
				return recordCell
			}else{
				let cell = tableView.dequeueReusableCell(withIdentifier: RECORD_BASE_CELL_ID, for: indexPath)
				return cell
			}
		}else{
			let cell = tableView.dequeueReusableCell(withIdentifier: RECORD_BASE_CELL_ID, for: indexPath)
			cell.selectionStyle = .none;
			return cell
		}
	}
	
	func updateHeadView(date:String, time:String, type:String){
		self.dateLabel.setDetail(title: "开始时间", desc: date)
		self.timeLabel.setDetail(title: "总时长", desc: time)
		self.typeLabel.setDetail(title: "模式", desc: type)
		
		let text = "模式:"+type
		var size = CGRect();
		size = getTextRectSize(text: text as NSString, font: UIFont.systemFont(ofSize: 12), size: CGSize(width: 10000, height: 12))
		self.typeLabel.snp.updateConstraints { (make) -> Void in
			make.width.equalTo(size.size.width)
		}
	}
	
	override func addNavigationBar() {
		super.addNavigationBar()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	lazy var headView: UIView = {
		let headView = UIView.init(frame: CGRect(x: 0, y: 64, width: Screen_Width, height: 32))
		
		self.dateLabel.setDetail(title: "开始时间", desc: "")
		self.timeLabel.setDetail(title: "总时长", desc: "")
		self.typeLabel.setDetail(title: "模式", desc: "")
		
		headView.addSubview(self.dateLabel)
		self.dateLabel.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(12);
			make.width.equalTo(100)
			make.left.equalTo(headView).offset(10)
			make.centerY.equalTo(headView)
		}
		
		headView.addSubview(self.timeLabel)
		self.timeLabel.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(12);
			make.width.equalTo(100)
			make.center.equalTo(headView)
		}
		
		headView.addSubview(self.typeLabel)
		self.typeLabel.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(12);
			make.width.equalTo(100)
			make.right.equalTo(headView.snp.right).offset(-10)
			make.centerY.equalTo(headView)
		}

		return headView
	}()
	
	lazy var dateLabel: LOLRecordDetailView = {
		let dateLabel = LOLRecordDetailView();
		return dateLabel;
	}()
	
	lazy var timeLabel: LOLRecordDetailView = {
		let timeLabel = LOLRecordDetailView();
		timeLabel.setTextAlighment(center: true)
		return timeLabel;
	}()
	
	lazy var typeLabel: LOLRecordDetailView = {
		let typeLabel = LOLRecordDetailView();
		return typeLabel;
	}()
}
