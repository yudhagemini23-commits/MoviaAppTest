//
//  MovieViewController.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    private let viewModel = MovieViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupBinding()
            
            viewModel.loadData()
        }
        
        func setupUI() {
            title = "Popular Movies"
            
            searchBar.isUserInteractionEnabled = true
            
            tableView.delegate = self
            tableView.dataSource = self
            searchBar.delegate = self
            
            searchBar.returnKeyType = .done
            
            let nib = UINib(nibName: "MovieCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "MovieCell")
            
            tableView.tableFooterView = UIView()
        }
        
        func setupBinding() {
            viewModel.onUpdate = { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            viewModel.onError = { [weak self] errorMsg in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }

    extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.displayedMovies.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
                return UITableViewCell()
            }
            
            let movie = viewModel.displayedMovies[indexPath.row]
            cell.configure(with: movie)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            print("Selected: \(viewModel.displayedMovies[indexPath.row].title)")
        }
    }

    extension MovieViewController: UISearchBarDelegate {
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            viewModel.searchMovie(query: searchText)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
