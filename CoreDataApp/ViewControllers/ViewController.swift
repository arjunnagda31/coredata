//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Mac on 7/4/18.
//  Copyright © 2018 Global Garner. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,MDDatePickerDialogDelegate {

    var imagePicker = UIImagePickerController()
    var selectedImage = UIImage()
    var dctEdit : Dictionary<String, Any>?
    
    
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var txtDob: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var btnDateSelect: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dctEdit != nil {
            self.initData()
        }
    }
    
    func initData() {
        
        if let strnm = self.dctEdit?["name"] as? String {
            txtName.text = strnm
        }
        if let strmob = self.dctEdit?["mobile"] as? String {
            txtMobile.text = strmob
        }
        
        if let strmob = self.dctEdit?["dob"] as? String {
            txtMobile.text = strmob
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let myStringafd = formatter.string(from: self.dctEdit?["dob"] as! Date)
        print(myStringafd)
        txtDob.text = myStringafd
        
        if let imgData = self.dctEdit?["imageData"] as? Data {
            imgProfile.image = UIImage.init(data:imgData )
            
        }
        
        
    }
    
    func openGallery()  {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK: PickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgProfile.image = selectedImage
    
    }
    
    
    @IBAction func btnClick_DateSelect(_ sender: Any) {
        let datePicker = MDDatePickerDialog()
        let component : DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date()) as DateComponents
        let currentDate : Date = Calendar.current.date(from: component)!
        datePicker.selectedDate = currentDate
        datePicker.calendar?.boundDate = currentDate;
        datePicker.delegate = self
        datePicker.show()
    }
    //MARK:- MDDatePickerDialogDelegate
    func datePickerDialogDidSelect(_ date: Date) {
        let selectedDate = Common.getFormattedStringFromDate(date: date, format: "yyyy/MM/dd")
        txtDob.text = selectedDate
        txtDob.isUserInteractionEnabled = false
    }
    @IBAction func btnClick_GoToList(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objListView = storyboard.instantiateViewController(withIdentifier: "ListViewController")
        self.navigationController?.pushViewController(objListView, animated: true)
        
    }
    
    
    @IBAction func btnClick_Submit(_ sender: Any) {
        
        if  (txtName.text?.isEmpty)! {
            Common.showMessage(message: "Please enter name.", withTitle: "", objVC: self)
            return
        }else  if  (txtMobile.text?.isEmpty)! {
            Common.showMessage(message: "Please enter mobile.", withTitle: "", objVC: self)
            return
        }else  if  (txtMobile.text?.count)! > 10 {
        Common.showMessage(message: "Please enter valide mobile no.", withTitle: "", objVC: self)
        return
        }
        else  if  (txtDob.text?.isEmpty)! {
            Common.showMessage(message: "Please enter Date of Birth.", withTitle: "", objVC: self)
            return
        }
        else  if  imgProfile.image == nil {
            Common.showMessage(message: "Please enter image.", withTitle: "", objVC: self)
            return
        }
        
        
        if self.dctEdit != nil {
            
            let date = Common.getFormattedDateFromString(strDate: txtDob.text!)
            guard let imageData = UIImageJPEGRepresentation(imgProfile.image!, 1) else {
                print("jpg error")
                return
            }
            CoreDataWrapper.updateData(dctEdit: self.dctEdit!, name: txtName.text!, mobile: txtMobile.text!, dob: date, imageData: imageData) { (status, error ) in
                if status == true {
                    self.clearData()
                    Common.showMessage(message: "update done.", withTitle: "", objVC: self)
                    
                }else{
                    self.clearData()
                    Common.showMessage(message: error, withTitle: "", objVC: self)
                    
                }
            }
            
        }else{
            
            let date = Common.getFormattedDateFromString(strDate: txtDob.text!)
            guard let imageData = UIImageJPEGRepresentation(imgProfile.image!, 1) else {
                print("jpg error")
                return
            }
            
            CoreDataWrapper.insertData(name: txtName.text!, mobile: txtMobile.text!, dob: date, imageData: imageData) { (status, error) in
                
                if status == true {
                    self.clearData()
                    Common.showMessage(message: "save done.", withTitle: "", objVC: self)

                }else{
                    self.clearData()
                    Common.showMessage(message: error, withTitle: "", objVC: self)

                }
            }
      }
    }
    
    
    @IBAction func btnClick_SelectImg(_ sender: Any) {
        self.openGallery()
    }
    
    func clearData()  {
              txtName.text = ""
              txtMobile.text = ""
              txtDob.text = ""
              imgProfile.image = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

