//
//  ViewController.swift
//  BugetBuddy
//
//  Created by Harsh Shah on 4/13/19.
//  Copyright © 2019 Harsh Shah. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 var locationDict: [String: String] = [:]
    var gSum = 0.00
    var ln:String?
    var ms:String?
    var t:String?
    var ri:Data?
    

    var counter  = 1
    @IBOutlet weak var locationTable: UITableView!

    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this is the array to store Fruit entities from the coredata
    var   fetchResults = [Location]()
    
  
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        let sort = NSSortDescriptor(key: "locationName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x   = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [Location])!
        
        
        x = fetchResults.count
        
        print(x)
        
        // return howmany entities in the coreData
        return x
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         self.locationTable.rowHeight = 150 //exp
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! locationTableViewCell
        cell.layer.borderWidth = 3.0
        cell.locationNameLabel.text = fetchResults[indexPath.row].locationName
        cell.amountLabel.text = fetchResults[indexPath.row].amountSpent
        cell.timeLabel.text = fetchResults[indexPath.row].timeStamp
      
        
        return cell
    }
    
 
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            // delete the selected object from the managed
            // object context
            managedObjectContext.delete(fetchResults[indexPath.row])
            // remove it from the fetch results array
            fetchResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try managedObjectContext.save()
            } catch {
                
            }
            // reload the table after deleting a row
            locationTable.reloadData()
        }
        
    }
    
    
    @IBAction func unwindToTable(_sender: UIStoryboardSegue)
    {
        print("got here")
        //Call add function from a certain model class here. add the following code to add location
        
        let ent =  NSEntityDescription.entity(forEntityName: "Location", in: self.managedObjectContext)
        
        let newItem = Location(entity: ent!, insertInto: self.managedObjectContext)
        
        newItem.locationName = ln
        newItem.amountSpent = ms
        newItem.timeStamp = t //exp
      //  newItem.reciptImage = UIImage(named:"download.png")?.pngData()
   
        
        let n = Double(ms!)
        print(n!)
      //  print(gSum!)
        gSum = gSum + n!
        self.locationTable.reloadData()
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
        self.locationTable.reloadData()
        
    }

    
    @IBAction func displayStats(_ sender: Any) {
        print("test")
        
        let alert = UIAlertController(title:"Your activity today", message: "The amount spent today $:\(gSum)", preferredStyle: .alert)
        
    
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        
        /*
         alert.addTextField(configurationHandler: { textField in
         textField.placeholder = "Enter a short description of the City Here"
         })
 */
        
        self.present(alert, animated: true)
        
    }
    
}

