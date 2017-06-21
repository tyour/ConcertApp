//
//  BookmarksTableViewController.swift
//  ConcertApp
//
//  Created by Eric  Chung on 6/20/17.
//  Copyright © 2017 Team2. All rights reserved.
//

import UIKit
import CoreData

class BookmarksTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var MyBookmarks : [EventObjectMO] = []
    var fetchResultsController : NSFetchedResultsController<EventObjectMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let fetchRequest : NSFetchRequest<EventObjectMO> = EventObjectMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "iName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    MyBookmarks = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            MyBookmarks = fetchedObjects as! [EventObjectMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MyBookmarks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BookmarkTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BookmarkTableViewCell
        var cellItem : EventObjectMO
        cellItem = MyBookmarks[indexPath.row]
        // Configure the cell...
        cell.EventName?.text = cellItem.iName
        cell.EventImage?.image = #imageLiteral(resourceName: "icon_dj")
        cell.EventTime?.text = cellItem.iDate

        // Fade-in animation of cells. We set initial state, duration, and final state
        cell.alpha = 0
        UIView.animate(withDuration: 2.5, animations: { cell.alpha = 1})
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let itemToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(itemToDelete)
                appDelegate.saveContext()
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "BMCelltoBMDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! BookmarkDetailViewController
                
                detailVC.BookmarkDetail = MyBookmarks[indexPath.row]
            }
        }
    }
    

}
