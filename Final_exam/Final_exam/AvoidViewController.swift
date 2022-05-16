//
//  ViewController.swift
//  Lab_7
//
//  Created by user202461 on 4/8/22.
//

import UIKit

class AvoidViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var questions=[
        Question(title:"Get Vaccinated and stay up to date on your COVID-19 vaccines"),
        Question(title:"Wear a mask"),
        Question(title:"Stay 6 feet away from others"),
        Question(title:"Avoid poorly ventilated spaces and crowds"),
        Question(title:"Test to prevent spread to others"),
        Question(title:"Wash your hands often"),
        Question(title:"Cover coughs and sneezes"),
        Question(title:"Clean and disinfect"),
        Question(title:"Monitor your health daily"),
        Question(title:"Follow recommendations for quarantine"),
        Question(title:"Follow recommendations for isolation"),
        Question(title:"Take precautions when you travel"),
        
   
        
    ]

    @IBAction func SaveButton(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showAlertModal(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Task", message: "Enter details", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            
            textField.placeholder = "Task Details"
        }
        


        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            guard let textFields = alertController.textFields else { return }
            
            if let taskDetails = textFields[0].text{
                print("TaskDetails: \(taskDetails)")
                
                let newTodo=Question(title:taskDetails)
                
                self.questions.append(newTodo)
                self.tableView.reloadData()
                
                
             
            }
            
            print("Ok button tapped");
        }
        alertController.addAction(OKAction)
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            (action: UIAlertAction!) in print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        // Present Dialog message
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}

extension AvoidViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell with delete") as! TableViewCellWithDelete
        
        let todo=questions[indexPath.row]
        

        
     
   
        cell.Title.lineBreakMode=NSLineBreakMode.byWordWrapping
        cell.Title.numberOfLines=0
        cell.Title.text=todo.title
      
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        questions.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    
}



