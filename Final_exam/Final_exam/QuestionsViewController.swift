//
//  ViewController.swift
//  Lab_7
//
//  Created by user202461 on 4/8/22.
//

import UIKit

class QuestionsViewsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var questions=[
        Question(title:"Have you had FEVER In Last 48 Hours"),
        Question(title:"Have you had COUGH In Last 48 Hours"),
        Question(title:"Have you had BREATHING PROBLEM In Last 48 Hours"),
        Question(title:"Have you had FATIGUE In Last 48 Hours"),
        Question(title:"Have you had BODY ACHE In Last 48 Hours"),
        Question(title:"Have you had HEADACHE In Last 48 Hours"),
        Question(title:"Have you had LOSS OF TASTE In Last 48 Hours"),
        Question(title:"Have you had SORE THROAT In Last 48 Hours"),
        Question(title:"Have you had RUNNY NOSE In Last 48 Hours"),
        Question(title:"Have you had NAUSEA In Last 48 Hours"),
        Question(title:"Have you had DIARRHEA In Last 48 Hours"),
        Question(title:"Have you tested positive for COVID-19 in past 10 days"),
        Question(title:"Are you currently awaiting test results ?"),
        Question(title:"Have you been diagnosed with COVID-19 by a medical professional in past 10 days"),
        Question(title:"Have you been told that you are suspected to have COVID by a health care professional"),
   
        
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

extension QuestionsViewsController:UITableViewDataSource{
    
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .delete
    }

}
