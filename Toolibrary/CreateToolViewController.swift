//
//  ViewController.swift
//  Toolibrary
//
//  Created by Jesus Quezada on 11/24/17.
//  Copyright © 2017 Jesus Quezada. All rights reserved.
//

import UIKit
import CoreData

class CreateToolViewController: UIViewController {
    var titleText = "Create Tool"
    var tool: NSManagedObject? = nil
    var indexPathForTool: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
        if let tool = self.tool {
            tooltypeTextField.text = tool.value(forKey: "tooltype") as? String
            materialTextField.text = tool.value(forKey: "material") as? String
            speedTextField.text = tool.value(forKey: "speed") as? String
            feedTextField.text = tool.value(forKey: "feed") as? String
            depthofcutTextField.text = tool.value(forKey: "depthofcut") as? String
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tooltypeTextField: UITextField!
    
    @IBOutlet weak var materialTextField: UITextField!
    
    @IBOutlet weak var speedTextField: UITextField!
    
    @IBOutlet weak var feedTextField: UITextField!
    
    @IBOutlet weak var depthofcutTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Navigation
    
    @IBAction func cancelButton(_ sender: UIButton) {
        tooltypeTextField.text = nil
        materialTextField.text = nil
        speedTextField.text = nil
        feedTextField.text = nil
        depthofcutTextField.text = nil
        performSegue(withIdentifier: "unwindToToolList", sender: self)
    }
    
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToToolList", sender: self)
    }
    
    
    

}

