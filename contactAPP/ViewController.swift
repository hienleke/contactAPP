//
//  ViewController.swift
//  contactAPP
//
//  Created by TMA on 5/13/21.
//

import UIKit
import Contacts
import ContactsUI


struct Section {
    let letter : String
    let names : [CNContact]
}
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, CNContactViewControllerDelegate{
    
    var sections = [Section]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addButton(_ sender: Any) {
        addNewcontact()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchAfterchange()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].names.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return sections.count
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map{$0.letter}
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    
    var results : [CNContact] = []
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row].givenName + " " + results[indexPath.row].familyName
        cell.detailTextLabel?.text = results[indexPath.row].phoneNumbers[0].value.stringValue
    return cell
      
        
    }
    
    func addNewcontact()
    {
        let con = CNContact()
            let vc = CNContactViewController(forNewContact: con)
            _ = self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let store = CNContactStore()
        var contact = results[indexPath.row]
        if !contact.areKeysAvailable([CNContactViewController.descriptorForRequiredKeys()]) {
            do {
                contact = try store.unifiedContact(withIdentifier: contact.identifier, keysToFetch: [CNContactViewController.descriptorForRequiredKeys()])
            }
            catch { }
        }
        let viewControllerforContact = CNContactViewController(for: contact)
      
    
        self.navigationController?.pushViewController(viewControllerforContact, animated: true)

    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            removeContact(index: indexPath.row)
            results.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        
        
       
       
    }
  
    
    func removeContact(index : Int)
    {
        let store = CNContactStore()
        let req = CNSaveRequest()
        let mutableContact = results[index].mutableCopy() as! CNMutableContact
        
        req.delete(mutableContact)
    
                do{
                    try store.execute(req)
                  print("Successfully deleted the user")

                } catch let e{
                  print("Error = \(e)")
                }

               catch let err{
                print(err)
              }
    }
    
    
    @objc func fetchAfterchange()
    {
        results.removeAll()
        fetchContacts()
        if let tableView = tableView {
            tableView.reloadData()
        }
      
    }
    
    @objc public func fetchContacts()
    {
       
        let store = CNContactStore()
        store.requestAccess(for: .contacts) {(granted, error) in
            if let error = error {
                print("fail")
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey,  CNContactPhoneNumbersKey , CNContactOrganizationNameKey, CNContactImageDataAvailableKey,CNContactEmailAddressesKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                request.sortOrder = CNContactSortOrder.userDefault
                do{
                    try store.enumerateContacts(with: request, usingBlock: {(contact, stopPointer) in
                        self.results.append(contact)
                    })
                } catch let error  {
                    print("fail")
                }
               
            }
            else{
                print("access denied")
            }
            
            let groupedDictionary = Dictionary(grouping: self.results, by: {String($0.familyName.prefix(1))})
            let keys = groupedDictionary.keys.sorted()
            self.sections = keys.map{Section(letter: $0, names: groupedDictionary[$0]!.sorted(by: {$0.familyName < $1.familyName}))}
            print(self.results)
        }
        
         
        
    }

}



