//
//  ViewController.swift
//  FlickrImagesSearch
//
//  Created by Oussama Ayed on 16/05/2018.
//  Copyright © 2018 Oussama Ayed. All rights reserved.
//

import UIKit
import SVProgressHUD

let numberOfRows = 3

class ViewController: UIViewController {

    fileprivate var photos = [Photo]()
    @IBOutlet weak var photosCollectionView: UICollectionView!
    fileprivate var currentPage: Int = 0
    fileprivate var searchText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func searchPhotos(completion: ((_ success: Bool) -> Void)?) -> Void {
        guard let searchText = searchText else { return }
        PhotoManager.searchPhotos(forQuery: searchText, page: currentPage, completion: { [weak self] photos in
            SVProgressHUD.dismiss()
            if self?.currentPage == 0 {
                self?.photos.removeAll()
            }
            self?.photos.append(contentsOf: photos)
            if self?.currentPage == 0 {
                self?.photosCollectionView?.reloadData()
            } else {
                self?.insertPhotos()
            }
            completion?(true)
        })
        
    }
    func insertPhotos()  {
        
        var indexPaths = [IndexPath]()
        for i in  limit * currentPage..<photos.count {
            let indexPath = IndexPath(item: i, section: 0)
            indexPaths.append(indexPath)
        }
        
        photosCollectionView?.insertItems(at: indexPaths)
        
    }
    func prepareViewForSearch(with text: String?) -> Void {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        searchText = text
        currentPage = 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? DetailViewController {
            //do something you want
            let path = self.photosCollectionView.indexPathsForSelectedItems?.first
            print("path : \(String(describing: path?.row))")
            let selectedRow:Photo = photos[path!.row]
            destination.photo = selectedRow
            
        }
        
    }

}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell
            else { return UICollectionViewCell() }
        
        cell.setUp(with: photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "searchReusableView", for: indexPath)
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (photos.count - 4) {
            currentPage += 1
            searchPhotos(completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfRows - 1))
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfRows))
            return CGSize(width: size, height: size)
        } else {
            // default size.
            return CGSize(width: 90, height: 90)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        prepareViewForSearch(with: searchBar.text)
        searchPhotos(completion: { success in
            if success {
                if let text = searchBar.text {
                }
                searchBar.text = nil
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


