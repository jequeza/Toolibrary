//
//  ToolEditViewController.swift
//  Toolibrary
//
//  Created by Jesus Quezada on 11/27/17.
//  Copyright © 2017 Jesus Quezada. All rights reserved.
//

import UIKit
import CoreData

class ToolinfoViewController: UIViewController {
    
    var tool: NSManagedObject? = nil
    var isDeleted: Bool = false
    var indexPath: IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tooltypeTxt.text = tool?.value(forKey:"tooltype") as? String
        materialTxt.text = tool?.value(forKey:"material") as? String
        speedTxt.text = tool?.value(forKey:"speed") as? String
        feedTxt.text = tool?.value(forKey:"feed") as? String
        depthofcutTxt.text = tool?.value(forKey:"depthofcut") as? String
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tooltypeTxt: UILabel!
    
    @IBOutlet weak var materialTxt: UILabel!
    
    @IBOutlet weak var speedTxt: UILabel!
    
    @IBOutlet weak var feedTxt: UILabel!
    
    @IBOutlet weak var depthofcutTxt: UILabel!
    
    @IBAction func deleteBtn(_ sender: UIButton) {
        isDeleted = true
        performSegue(withIdentifier: "unwindToToolList", sender: self)

    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToToolList", sender: self)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editToolSegue" {
        guard let viewController = segue.destination as? CreateToolViewController else { return }
            viewController.titleText = "Edit Tool"
            viewController.tool = tool
            viewController.indexPathForTool = self.indexPath!
    }


}


}
