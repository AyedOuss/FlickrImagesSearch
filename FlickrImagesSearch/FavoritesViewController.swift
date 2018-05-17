//
//  FavoritesViewController.swift
//  FlickrImagesSearch
//
//  Created by Oussama Ayed on 17/05/2018.
//  Copyright © 2018 Oussama Ayed. All rights reserved.
//

import UIKit
import CoreData
let reuseIdentifier = "cell";
class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [NSManagedObject]()
    func fetchPhotos()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FlickrImages")
        do{
            let result = try managedContext.fetch(fetchRequest)
            
            self.photos = result as! [NSManagedObject]
            
        }
        catch let error as NSError {
            let alert = UIAlertController(title: "Fetch tasks", message: "Could not fetch \(error)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        fetchPhotos();
        collectionView.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as UICollectionViewCell
        
         //cell.backgroundColor = self.randomColor()
        let imgView:UIImageView = cell.viewWithTag(1) as! UIImageView
        let photo = photos[indexPath.row]
        print(photo)
        let url = photo.value(forKey: "urlImage") as! String
    
        
            imgView.layer.cornerRadius = 10.0
            
            imgView.kf.setImage(with: URL(string: url))
       
        
        
        
        return cell
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
