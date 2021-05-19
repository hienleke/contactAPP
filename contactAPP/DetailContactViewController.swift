//
//  DetailContactViewController.swift
//  contactAPP
//
//  Created by TMA on 5/16/21.
//

import UIKit

import Contacts

class DetailContactViewController: UIViewController {

    var contact : CNContact?
    
  
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        firstName.text = contact!.givenName
//        lastName.text = contact!.familyName
//       
//
//        if (contact!.organizationName != nil)
//        {
//            company.text = contact!.organizationName
//       }
        
        

    }
    
    @IBAction func editContact(_ sender: Any) {
        let store = CNContactStore()
        guard let mutableContact = contact!.mutableCopy() as? CNMutableContact else { return }
        let newEmail = CNLabeledValue(label: CNLabelHome, value: "john@example.com" as NSString)
      
        
        
        
        mutableContact.emailAddresses.append(newEmail)

        let saveRequest = CNSaveRequest()
        saveRequest.update(mutableContact)
        do {
            try store.execute(saveRequest)
            print("saving success")
        } catch {
            print("Saving contact failed, error: \(error)")
            // Handle the error
        }
      
    }
    
    
   
}
