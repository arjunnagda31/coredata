//
//  ListViewController.swift
//  CoreDataApp
//
//  Created by Mac on 7/4/18.
//  Copyright © 2018 Global Garner. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {

    @IBOutlet var tblViewList: UITableView!
    
    var people: [NSManagedObject] = []

    
    // MARK: Initializer
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewList.rowHeight = UITableViewAutomaticDimension
        tblViewList.estimatedRowHeight = 100.0
        
        self.GetSaveData()
        
    }
   
    func GetSaveData() {
        
        CoreDataWrapper.getData { (objData, status, error) in
            self.people = objData
            if self.people.count != 0{
                print(self.people)
                self.tblViewList.reloadData()

            }else{
                self.tblViewList.reloadData()
                Common.showMessage(message: "No record found.", withTitle: "", objVC:self)
            }
        }
    }
    
    @objc func btnClick_Delete(_ sender: UIButton)
    {
        
        let person = people[sender.tag]

        let strName = person.value(forKeyPath: "name") as? String
        let strMobile =  person.value(forKeyPath: "mobile") as? String
        let date = person.value(forKeyPath: "dob") as? Date
        let imgData = person.value(forKeyPath: "imageData") as? Data
        
        CoreDataWrapper.deleteData(dctEdit: ["name": strName! ,"dob" : date! ,  "mobile": strMobile!, "tag" : Int(sender.tag),"imageData":imgData!]) { (status, error) in
                if status == true {
                    print("delete done.")
                    self.GetSaveData()
    
                }else{
                    Common.showMessage(message: error, withTitle: "", objVC: self)
    
                }
        }
        
    }
    // MARK: Button Click Edit
    @objc func btnClick_edit(_ sender: UIButton)
    {
        let person = people[sender.tag]
        
//        var dctEditValue = [String : Any]()
//        
//        if let strNm = person.value(forKeyPath: "name") as? String{
//            dctEditValue["name"] = strNm
//        }
//
//        if let strMobile = person.value(forKeyPath: "mobile") as? String{
//            dctEditValue["mobile"] = strMobile
//        }
//
//        if let date = person.value(forKeyPath: "dob") as? Date{
//            dctEditValue["dob"] = date
//        }
//
//        if let imgData = person.value(forKeyPath: "imageData") as? Data{
//            dctEditValue["imageData"] = imgData
//        }
        
        let strName = person.value(forKeyPath: "name") as? String
        let strMobile =  person.value(forKeyPath: "mobile") as? String
        let date = person.value(forKeyPath: "dob") as? Date
        let imgData = person.value(forKeyPath: "imageData") as? Data
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        objViewController.dctEdit = ["name": strName! ,"dob" : date! ,  "mobile": strMobile!, "tag" : Int(sender.tag),"imageData":imgData!]
        self.navigationController?.pushViewController(objViewController, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateRecord() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        let empId = "abc"
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EmpDetails")
        let predicate = NSPredicate(format: "name = '\(empId)'")
        fetchRequest.predicate = predicate
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 1
            {
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue("newName", forKey: "name")
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                let date = formatter.date(from: "1990/10/12")
                objectUpdate.setValue(date, forKey: "dob")
                objectUpdate.setValue("0000001", forKey: "mobile")
                do{
                    try managedContext.save()
                    print("done update")
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
    }
}


extension ListViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ListTableCell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell", for: indexPath) as! ListTableCell
        
        let person = people[indexPath.row]
        
        let formatter = DateFormatter()
        //            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = "yyyy/MM/dd"
        let myStringafd = formatter.string(from: (person.value(forKeyPath: "dob") as? Date)!)
        print(myStringafd)
        cell.lblDob?.text = myStringafd
        
        cell.lblName?.text =
            person.value(forKeyPath: "name") as? String
        cell.lblMobile?.text =
            person.value(forKeyPath: "mobile") as? String
        
        if let imgData = person.value(forKeyPath: "imageData") as? Data {
            cell.imgProfle.image = UIImage.init(data:imgData )
            
        }
        
        
        
        cell.btnEdit.removeTarget(self, action: nil, for: .allEvents)
        cell.btnDelete.removeTarget(self, action: nil, for: .allEvents)

        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row

        cell.btnEdit.addTarget(self, action: #selector(btnClick_edit(_:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(btnClick_Delete(_:)), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("in didselect")
    }
    
    
}
