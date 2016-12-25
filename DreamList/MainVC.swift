//
//  MainVC.swift
//  DreamList
//
//  Created by AKIL KUMAR THOTA on 12/23/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller : NSFetchedResultsController<Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        //generateTestData()
        attemptFetch()
        noLabelCheck()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let section = controller.sections {
            return section.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectioninfo = sections[section]
            return sectioninfo.numberOfObjects
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        configureCell(cell: cell, indexpath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let itemvisible = objs[indexPath.row]
        
        performSegue(withIdentifier: "ItemDetailsVC", sender: itemvisible )
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination = segue.destination as? ItemDetailsVC {
            if let item = sender as? Item {
                destination.itemToEdit = item
            }
        }
    }
    
    func configureCell(cell : ItemCell, indexpath: NSIndexPath) {
        
        let item = controller.object(at: indexpath as IndexPath)
        
        cell.configureCell(item: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func attemptFetch() {
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        let datesort = NSSortDescriptor(key: "created", ascending: false)
        let titlesort = NSSortDescriptor(key: "title", ascending: true)
        let pricesort = NSSortDescriptor(key: "price", ascending: true)
        let categorysort = NSSortDescriptor(key: "type", ascending: true)
        
        if segment.selectedSegmentIndex == 0{
        fetchRequest.sortDescriptors = [datesort]
        } else if segment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [titlesort]

        } else if segment.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [pricesort]

        } else if segment.selectedSegmentIndex == 3 {
            fetchRequest.sortDescriptors = [categorysort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch let err as NSError{
            
            print(err)
            
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.beginUpdates()
        noLabelCheck()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableview.endUpdates()
        noLabelCheck()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case .insert:
            if let indexpath = newIndexPath{
                tableview.insertRows(at: [indexpath], with: .fade)
                noLabelCheck()
            }
            break
            
            
        case .delete:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
                
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case .update:
            if let indexPath = indexPath {
                let cell = tableview.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell: cell, indexpath: indexPath as NSIndexPath)
            }
            break
        
            
        
        }
    }
    
    func generateTestData() {
        let item = Item(context: context)
        
        item.title = "Ps4 Pro"
        item.price = 200
        item.details = "I love ps4 more than ps3 and it was a big update"
        item.type = "Electronics"
        
        let item2 = Item(context: context)
        
        item2.title = "Tesla Model S"
        item2.price = 160000
        item2.details = "Amazing Car"
        item2.type = "Vehicle"
        
        ad.saveContext()
    }
    
    @IBAction func segmentChand(_ sender: UISegmentedControl) {
        attemptFetch()
        tableview.reloadData()
    }
    
    func noLabelCheck() {
        if let objs = controller.fetchedObjects {
            if objs.count == 0 {
                let noDataLabel: UILabel = UILabel(frame: tableview.bounds)
                noDataLabel.text             = "No data available"
                noDataLabel.textColor        = UIColor.black
                noDataLabel.textAlignment    = .center
                tableview.backgroundView = noDataLabel
                tableview.separatorStyle = .none
            }
            else {
                tableview.backgroundView = nil
            }
        }
    }
    

   


}

