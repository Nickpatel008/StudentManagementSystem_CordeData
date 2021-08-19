//
//  AllStudentDataPageVC.swift
//  Student_Management_System_SQLite
//
//  Created by Nick patel on 30/07/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import UIKit

class AllStudentDataPageVC: UIViewController {

    private var studArr = [TBLSTUDENT]()
    
    private let myTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        view.addSubview(myTableView)
        
        setup()
       // studArr = Sql.FetchStudent()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studArr = CoreDataHandler.shared.fetch()
        
        myTableView.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myTableView.frame = CGRect(x: 0, y: 40, width: view.width, height: view.height)
        
    
        
    }
 
}

extension AllStudentDataPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func setup()
    {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Student")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Student", for: indexPath)
        let stud = studArr[indexPath.row]
        cell.textLabel?.text = "\(stud.spid) \t \(stud.name!) \t \(stud.course!) \t \(String(describing: stud.password))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let stud = studArr[indexPath.row]
        
        if editingStyle == .delete {
            myTableView.beginUpdates()
            CoreDataHandler.shared.delete(stud: stud){
                [weak self] in
                self?.studArr.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            myTableView.endUpdates()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AddNewStudentPageVC()
        vc.student = studArr[indexPath.row]
    
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
