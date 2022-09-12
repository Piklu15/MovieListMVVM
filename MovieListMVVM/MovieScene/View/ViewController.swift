//
//  ViewController.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import UIKit

class ViewController: UIViewController {
    let cellReuseID = "MovieTableViewCell"
    let movieQueryBaseUrl = "https://api.themoviedb.org/3/search/movie?api_key=a42e5ead0dd5ae986e1f31cf352051d4&query="

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!

    let movieViewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        movieViewModel.getMovieList()
        movieViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }

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
        return movieViewModel.movieCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! MovieTableViewCell

        let cvm = movieViewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cvm
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBarText = searchBar.text
        if let percentEncodingString = searchBarText?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let finalQueryUrl = movieQueryBaseUrl + percentEncodingString
            movieViewModel.getMovieList(finalQueryUrl)
        }
    }
}

