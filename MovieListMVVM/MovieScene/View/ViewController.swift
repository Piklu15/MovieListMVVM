//
//  ViewController.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import UIKit

class ViewController: UIViewController {
    let cellReuseID = "MovieTableViewCell"
    @IBOutlet weak var movieTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func configureTableView() {
        movieTableView.dataSource = self
        movieTableView.register(UINib(nibName: cellReuseID, bundle: nil), forCellReuseIdentifier: cellReuseID)
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)

        if let movieTableViewCell = cell as? MovieTableViewCell {

        }

        return cell
    }
}

