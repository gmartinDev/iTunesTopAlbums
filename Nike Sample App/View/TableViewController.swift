//
//  TableViewController.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/22/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    private let rowHeight: CGFloat = 75
    private let albumViewModel = AlbumViewModel()
    private let tableTitle = "Top 100 Albums"
    
    private let albumCellReuseId = "albumTypeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = rowHeight
        tableView.separatorInset = UIEdgeInsets()
        //Register table cell
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: albumCellReuseId)
        
        // Set title of nav bar
        title = tableTitle
        
        // When data is updated from ViewModel reload the table
        albumViewModel.didSetAlbumList = { [weak self] in
            self?.removeSpinner()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // When error is updated from ViewModel show alert of error string
        albumViewModel.didSetError = { [weak self] in
            self?.removeSpinner()
            let alert = UIAlertController(title: "An error has occurred",
                                          message: self?.albumViewModel.errorString,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(UIAlertAction(title: "Reload", style: .default) { _ in
                self?.getAlbums()
                DispatchQueue.main.async {
                    alert.dismiss(animated: true, completion: nil)
                }
            })
            
            DispatchQueue.main.async {
                self?.present(alert, animated: true)
            }
        }
        self.getAlbums()
    }
    
    // Call api to get list of albums - shows spinner
    private func getAlbums() {
        self.showSpinner(onView: self.view)
        albumViewModel.getAlbumList()
    }

    // MARK: - Table view data source
    /// Returns the number of rows in a given section of the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumViewModel.rssFeedList.results?.count ?? 0
    }

    /// UITableViewController function - returns the a cell that will be placed at a given index in the given tableview
    /// - Parameters:
    ///   - tableView: The table view the cell made in
    ///   - indexPath: The index path of the cell in the table view
    /// - Returns: A cell in the tableview at the index path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: albumCellReuseId, for: indexPath) as? AlbumTableViewCell {
            if let results = albumViewModel.rssFeedList.results {
                cell.albumInfo = results[indexPath.row]
            }
            
            return cell
        } else {
            //if we couldnt cast a cell to AlbumTypeCell create a new cell
            let cell = AlbumTableViewCell(style: .default, reuseIdentifier: albumCellReuseId)
            // Configure the cell...
            if let results = albumViewModel.rssFeedList.results {
                cell.albumInfo = results[indexPath.row]
            }
            return cell
        }
    }
    
    /// UITableViewController function - sets the height for each row within the table
    /// - Parameters:
    ///   - tableView: The table view that contains the cells
    ///   - indexPath: The index path of the cell within the table
    /// - Returns: The height a row at a given index path
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    /// Function that is called when a cell is selected within the table
    /// - Parameters:
    ///   - tableView: The table view that contains the selected cell
    ///   - indexPath: The index path of the cell within the table
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell: AlbumTableViewCell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell {
            if let selectedAlbum = selectedCell.albumInfo {
                let detailVC = AlbumDetailView()
                detailVC.albumInfo = selectedAlbum
                tableView.deselectRow(at: indexPath, animated: false)
                self.present(detailVC, animated: true)
                return
            }
        }
        //Alert if we couldnt present the detail view
        let alert = UIAlertController(title: "An error has occurred",
                                      message: "Error occured trying to display the album detail view",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }
}
