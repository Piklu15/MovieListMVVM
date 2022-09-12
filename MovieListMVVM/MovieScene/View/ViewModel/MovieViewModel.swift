//
//  MovieViewModel.swift
//  MovieListMVVM
//
//  Created by Piklu Majumder-401 on 9/4/22.
//

import Foundation

class MovieViewModel: NSObject {
    let baseImagePath = "https://image.tmdb.org/t/p/w500"
    private var movieService: MovieService

    var reloadTableView: (() -> Void)?

    var movies = Movies()

    var movieCellViewModels = [MovieCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }

    init(movieService: MovieService = MovieService()) {
        self.movieService = movieService
    }

    func getMovieList(_ url: String = MovieService.defautlUrl) {
        movieService.getMovieList(url) { success, model, error in
            if success, let movies = model {
                self.fetchData(movies: movies)
            } else {
                print(error!)
            }
        }
    }

    func fetchData(movies: Movies) {
        self.movies = movies // Cache
        var vms = [MovieCellViewModel]()
        for movie in movies{
            vms.append(createCellModel(movie: movie))
        }
        movieCellViewModels = vms
    }

    func createCellModel(movie: Movie) -> MovieCellViewModel {
        let title = movie.title
        let desc = movie.overview
        let imageUrl = baseImagePath + movie.imageUrl

        return MovieCellViewModel(title: title, dess: desc, image: AsyncImage(url: imageUrl))
    }

    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return movieCellViewModels[indexPath.row]
    }
}
