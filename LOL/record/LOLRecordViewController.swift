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

class LOLRecordViewController: LOLBaseViewController, UITableViewDelegate, UITableViewDataSource {
	var game_id:String = ""
	var tableView = UITableView()
	var gameDetail = NSArray()

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
					
					self.gameDetail = result["team"] as! NSArray
					
					self.tableView.reloadData()
				}
			}
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
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
		leftResultLabel.backgroundColor = LOLGREEN
		leftResultLabel.text = "胜利方"
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
		rightResultLabel.textColor = LOLGREEN
		rightResultLabel.textAlignment = .right

		return sectionHeadView
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 105
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		self.tableView.deselectRow(at: indexPath, animated: true)
//		let recordView = LOLRecordViewController()
//		self.navigationController?.pushViewController(recordView , animated: true)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell:LOLRecordDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: RECORD_DETAIL_CELL_ID, for: indexPath) as! LOLRecordDetailTableViewCell
		if(self.gameDetail.count == 2){
			let dic = (self.gameDetail[indexPath.section] as! NSArray)[indexPath.row] as! NSDictionary
			let champion_id = String(describing: dic["champion_id"]!)
			let level = String(describing: dic["level"]!)
			let gameKDAKill = String(describing: dic["champions_killed"]!)
			let gameKDAAssists = String(describing: dic["assists"]!)
			let gameKDADeath = String(describing: dic["num_deaths"]!)
			let gameKDAString = gameKDAKill+"/"+gameKDADeath+"/"+gameKDAAssists
			let eqpts:Array<String> = [
				"http://ossweb-img.qq.com/images/lol/img/item/"+String(describing: dic["item0"]!)+".png",
				"http://ossweb-img.qq.com/images/lol/img/item/"+String(describing: dic["item1"]!)+".png",
				"http://ossweb-img.qq.com/images/lol/img/item/"+String(describing: dic["item2"]!)+".png",
				"http://ossweb-img.qq.com/images/lol/img/item/"+String(describing: dic["item3"]!)+".png",
				"http://ossweb-img.qq.com/images/lol/img/item/"+String(describing: dic["item4"]!)+".png",
				"http://ossweb-img.qq.com/images/lol/img/item/"+String(describing: dic["item5"]!)+".png",
				"http://ossweb-img.qq.com/images/lol/img/item/"+String(describing: dic["item6"]!)+".png",
			]
			cell.setDetail(championImage: "http://cdn.tgp.qq.com/pallas/images/champions_id/"+champion_id+".png", level: level, userName: dic["name"] as! String, kda: gameKDAString, eqpts: eqpts)
		}
		cell.selectionStyle = .none;
		return cell
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
