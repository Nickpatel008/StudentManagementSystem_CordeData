//
//  StudentNoticeBoardVC.swift
//  Student_Management_System_SQLite
//
//  Created by Nick patel on 30/07/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import UIKit

class StudentNoticeBoardVC: UIViewController {

    private var noticeArr = [TBLNOTICE]()
    
    private let myTableView = UITableView()
       
     private let mylabel:UILabel = {
         let lbl = UILabel()
         lbl.text = "Notice Board"
         lbl.font = UIFont.boldSystemFont(ofSize: 25)
         lbl.textColor = .black
         return lbl
     } ()
     
     private let logOutBtn:UIButton = {
         let btn = UIButton()
         btn.backgroundColor = .black
         btn.setTitle("Home", for: .normal)
         btn.addTarget(self, action: #selector(handleHomeBtn), for: .touchUpInside)
         btn.tintColor = .black
         return btn
     } ()
    
    
     override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
           
           view.backgroundColor = .white
           

            view.addSubview(mylabel)
            view.addSubview(logOutBtn)
        
            view.addSubview(myTableView)
        
            setup()
         
        
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noticeArr = NoticeCoreData.sh.fetch_notice()
        myTableView.reloadData()
    }
       
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           

           mylabel.frame = CGRect(x: 40, y: 80, width: 300, height: 40)
           logOutBtn.frame = CGRect(x: 280, y: 80, width: 50, height: 40)
            myTableView.frame = CGRect(x: 0, y: 130, width: view.width, height: view.height)
        
       }

    
       @objc func handleHomeBtn()
       {
           navigationController?.popViewController(animated: true)
       }
    
}

extension StudentNoticeBoardVC: UITableViewDelegate, UITableViewDataSource {
    
    func setup() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Notice")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Notice", for: indexPath)
        let nts = noticeArr[indexPath.row]
        cell.textLabel?.text = "\(nts.title) \t \(nts.desc)"
        return cell
    }
    
    
}
