//
//  TableViewController.swift
//  MemoApp
//
//  Created by Abdalla on 7/23/19.
//  Copyright © 2019 edu.data. All rights reserved.
//
import CoreData
import UIKit

class TableViewController: UITableViewController {
    
    var items: [NSManagedObject] = []
    @IBAction func btn_add(_ sender: Any) {
        let alertt = UIAlertController(title: "add", message: "add to Notes", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default){(action) in
            let it = (alertt.textFields?.first)?.text
            self.save(note: it!)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertt.addTextField(configurationHandler:nil)
        alertt.addAction(saveAction)
        alertt.addAction(cancelAction)
        
        present(alertt, animated: true, completion: nil)
    }
    
    func save(note: String) {
            let ad = UIApplication.shared.delegate as! AppDelegate
            let connection = ad.persistentContainer.viewContext
            let new = NSEntityDescription.insertNewObject(forEntityName: "Item", into: connection)
            
            new.setValue(note, forKey: "note")
        
            do{
                try connection.save()
                items.append(new)
                
                }catch{
                print("failed")
            }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ad = UIApplication.shared.delegate as! AppDelegate
        let connection = ad.persistentContainer.viewContext
        
        do{
            items = try connection.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: "Item")) as! [NSManagedObject]
        }catch{
            print("Error...........")
        }

    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cell
    } */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.value(forKeyPath: "note") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)

            
            /*let appDelegate = UIApplication.shareanyItemd.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
            requestDel.returnsObjectsAsFaults = false
            // If you want to delete data on basis of some condition then you can use NSPredicate
            //  let predicateDel = NSPredicate(format: "age > %d", argumentArray: [10])
            // requestDel.predicate = predicateDel
            
            do {
                let arrUsrObj = try context.fetch(requestDel)
                for usrObj in arrUsrObj as! [NSManagedObject] { // Fetching Object
                    context.delete(usrObj) // Deleting Object
                }
            } catch {
                print("Failed")
            }
            
            // Saving the Delete operation
            do {
                try context.save()
            } catch {
                print("Failed saving")
            } */
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
