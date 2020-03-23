//
//  ViewController.swift
//  Mobiquity Test
//
//  Created by Afzal Murtaza on 21/03/2020.
//  Copyright © 2020 Afzal Murtaza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, StoryboardInitializable {
    static func storyboardName() -> String {
        return "Main"
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    lazy var searchController = UISearchController()
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: MainViewModel!
    private var resultsTableController: HistoryTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.contentInsetAdjustmentBehavior = .never
        self.setUpSearchController()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchController.isActive = true
    }
    
    private func setUpSearchController() {
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.showsCancelButton = true
        self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
    }
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    private func insertRowns(at indexes: [IndexPath]) {
        if indexes.count > 0 {
            DispatchQueue.main.async {
                self.collectionView.insertItems(at: indexes)
            }
        }
    }
    private func loadHistoryAndData(text: String) {
        self.hideIndicator()
        self.viewModel.saveHistory(text: text)
        self.reloadCollectionView()
    }
    private func searchUserInput(text: String) {
        viewModel.resetPage()
        if !text.isEmpty {
            self.showIndicator()
            viewModel.fetchImages(searchText: text) {[weak self] _ in
                guard let self = self else {return}
                self.loadHistoryAndData(text: text)
            }
        }
        else {
            self.reloadCollectionView()
        }
    }
}
extension MainViewController {
    // MARK: - Indicator
    func showIndicator() {
        self.activityIndicator.startAnimating()
    }
    func hideIndicator() {
        DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        }
    }
}
extension MainViewController:UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

extension MainViewController : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.dismiss(animated: true, completion: nil)
        if let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            self.searchUserInput(text: text)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),text.isEmpty {
        }
    }
}
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = ImageCollectionViewCell.dequeue(collectionView: collectionView, indexPath: indexPath)
        imageCell.viewModel = viewModel.viewModelForImage(for: indexPath)
        return imageCell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImageCollectionViewCell{
            cell.loadImage()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.size.width / 2, height: view.bounds.size.width / 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    // MARK: - Getting scroll down event here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)){
                // MARK: - Start loading new data
                viewModel.loadMore { [weak self] indexPaths in
                     guard let self = self else {return}
                     guard let paths = indexPaths else {return}
                     self.insertRowns(at: paths)
                }

            }
        }
    }
}
extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistory" {
            let vc = segue.destination as! HistoryTableViewController
            vc.delegate = self
            vc.viewModel = HistoryTableViewModelImp.init()
        }
    }
}
extension MainViewController: HistoryTableViewControllerDelegate {
    func searchTextSelect(text: String) {
        if searchController.isActive {
            searchController.dismiss(animated: true, completion: nil)
        }
        self.searchUserInput(text: text)
    }
}
