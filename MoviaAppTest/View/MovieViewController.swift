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
            
            // Mulai ambil data
            viewModel.loadData()
        }
        
        func setupUI() {
            title = "Popular Movies"
            
            searchBar.isUserInteractionEnabled = true
            
            // Delegate & DataSource
            tableView.delegate = self
            tableView.dataSource = self
            searchBar.delegate = self
            
            // Setup SearchBar agar tombol 'Done' muncul
            searchBar.returnKeyType = .done
            
            // ⚠️ REGISTER XIB CELL (WAJIB UNTUK XIB) ⚠️
            let nib = UINib(nibName: "MovieCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "MovieCell")
            
            // Hilangkan garis-garis kosong di bawah list
            tableView.tableFooterView = UIView()
        }
        
        func setupBinding() {
            // Saat data update -> Reload TableView
            viewModel.onUpdate = { [weak self] in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            // Saat error -> Munculkan Alert
            viewModel.onError = { [weak self] errorMsg in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
    }

    // --- EXTENSION: TABLE VIEW ---
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
            return 140 // Sesuaikan dengan tinggi desain XIB Bapak
        }
        
        // Opsional: Klik Row untuk print judul (bisa dikembangkan ke Detail Page)
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            print("Selected: \(viewModel.displayedMovies[indexPath.row].title)")
        }
    }

    // --- EXTENSION: SEARCH BAR ---
    extension MovieViewController: UISearchBarDelegate {
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Real-time search saat ngetik
            viewModel.searchMovie(query: searchText)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Tutup keyboard saat enter
        }
    }
