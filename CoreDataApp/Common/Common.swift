//
//  Common.swift
//  CoreDataApp
//
//  Created by Mac on 7/4/18.
//  Copyright © 2018 Global Garner. All rights reserved.
//

import UIKit

class Common: NSObject {
    
    
    class func isValidEmail(email:String) -> Bool {
        
        let emailRegex : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest : NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with:email)
    }
    
    class func showMessage(message: String, withTitle: String, objVC: UIViewController){
        let alert: UIAlertController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        objVC.present(alert, animated: true, completion: nil)
        
    }
    class func getFormattedStringFromDate(date: Date, format : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from:date as Date)
        
        return dateString
    }
    
    class func getFormattedDateFromString(strDate : String) -> Date {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: strDate)
        return date!
    }
    
   

    
}
