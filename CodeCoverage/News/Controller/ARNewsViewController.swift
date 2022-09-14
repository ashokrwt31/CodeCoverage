//
//  ARNewsViewController.swift
//  CodeCoverage
//
//  Created by Ashok Rawat on 14/09/22.
//

import UIKit

class ARNewsViewController: UIViewController {

    @IBOutlet weak var newTableView: UITableView!
    var newsVMSource: [NewsVMSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.newTableView.register(UINib(nibName: "ARNewsCell", bundle: .main), forCellReuseIdentifier: "ARNewsCell")
        let news = NewsViewModel()
        news.callAPI { (newsSource, error) in
            
            guard let newsVMSource = newsSource else {
                print(error.debugDescription)
                return
            }
            self.newsVMSource = newsVMSource
            DispatchQueue.main.async {
                self.newTableView.reloadData()
            }
        }
    }


}

extension ARNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsVMSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newTableView.dequeueReusableCell(withIdentifier: "ARNewsCell", for: indexPath) as? ARNewsCell {
            cell.cellConfiguration(newsVMSource: newsVMSource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
