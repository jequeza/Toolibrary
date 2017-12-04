//
//  ToolTableViewController.swift
//  Toolibrary
//
//  Created by Jesus Quezada on 11/27/17.
//  Copyright © 2017 Jesus Quezada. All rights reserved.
//

import UIKit
import CoreData

class ToolTableViewController: UITableViewController {
    
    var tools: [NSManagedObject] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Tool")
        do {
           tools = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tools.count
    }
    
    func save(tooltype: String, material: String, speed: String, feed: String, depthofcut: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName:"Tool", in: managedObjectContext) else { return }
        let tool = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        tool.setValue(tooltype, forKey:"tooltype")
        tool.setValue(material, forKey:"material")
        tool.setValue(speed, forKey:"speed")
        tool.setValue(feed, forKey:"feed")
        tool.setValue(depthofcut, forKey:"depthofcut")
        do {
            try managedObjectContext.save()
            self.tools.append(tool)
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    func update(indexPath: IndexPath, tooltype: String, material: String, speed: String, feed: String, depthofcut: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let tool = tools[indexPath.row]
        tool.setValue(tooltype, forKey:"tooltype")
        tool.setValue(material, forKey:"material")
        tool.setValue(speed, forKey:"speed")
        tool.setValue(feed, forKey:"feed")
        tool.setValue(depthofcut, forKey:"depthofcut")
        do {
            try managedObjectContext.save()
            tools[indexPath.row] = tool
        } catch let error as NSError {
            print("Could not update. \(error)")
        }
    }
    
    
    func delete(_ tool: NSManagedObject, at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(tool)
        tools.remove(at: indexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToolCell", for: indexPath)

        
        let tool = tools[indexPath.row]
        
        cell.textLabel?.text = tool.value(forKey:"tooltype") as? String
        cell.detailTextLabel?.text = tool.value(forKey:"material") as? String
        
        return cell
    }
 
    // MARK: - Navigation
    
    //Unwind segue
   @IBAction func unwindToToolList(segue: UIStoryboardSegue) {
    if let viewController = segue.source as? CreateToolViewController {
        guard let tooltype: String = viewController.tooltypeTextField.text, let material: String = viewController.materialTextField.text, let speed: String = viewController.speedTextField.text, let feed: String = viewController.feedTextField.text, let depthofcut: String = viewController.depthofcutTextField.text else { return }
        if tooltype != "" && material != "" && speed != "" && feed != "" && depthofcut != "" {
                if let indexPath = viewController.indexPathForTool {
                update(indexPath: indexPath, tooltype: tooltype, material: material, speed: speed, feed: feed, depthofcut: depthofcut)
    
            } else {
                save(tooltype:tooltype, material:material, speed:speed, feed:feed, depthofcut:depthofcut)
            }
          
        }
          tableView.reloadData()
        
        } else if let viewController = segue.source as? ToolinfoViewController {
        if viewController.isDeleted {
            guard let indexPath: IndexPath = viewController.indexPath else { return }
            let tool = tools[indexPath.row]
            delete(tool, at: indexPath)
            tableView.reloadData()
        }
     }
    
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToolinfoSegue" {
           guard let viewController = segue.destination as? ToolinfoViewController else { return }
           guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let tool = tools[indexPath.row]
            viewController.tool = tool
            viewController.indexPath = indexPath
        }
    }
    
}
