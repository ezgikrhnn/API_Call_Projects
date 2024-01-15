//
//  ViewController.swift
//  QuizAppMVVM
//
//  Created by Ezgi Karahan on 15.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    var viewModel = QuestionViewModel()
    var questionData: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TableView.dataSource = self
        TableView.delegate = self
        viewModel.getAllTheQuestions { [weak self] in
            self?.questionData = self?.viewModel.questionModel
            DispatchQueue.main.async {
                self?.TableView.reloadData()
            }
           
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionData?.data?.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = questionData?.data?.questions?[indexPath.row].question
        return cell!
        
        }
    
    
    
}





/**let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
 cell?.textLabel?.text = questionData?.data?.questions?[indexPath.row].question
 return cell!
*/

