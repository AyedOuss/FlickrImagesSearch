//
//  DetailViewController.swift
//  FlickrImagesSearch
//
//  Created by Oussama Ayed on 17/05/2018.
//  Copyright © 2018 Oussama Ayed. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData
class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    var photo = Photo(with:["":(Any).self] )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = photo.url {
            detailImage.layer.cornerRadius = 10.0
            print(url)
            
            detailImage?.kf.setImage(with: URL(string: url))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FlickrImages", in: managedContext)!
        
        let photos = NSManagedObject(entity: entity, insertInto: managedContext)
        
        photos.setValue(photo.url, forKey: "urlImage")
        
        do {
            try managedContext.save()
            
            
        } catch let error as NSError {
            let alert = UIAlertController(title: "Add Favorite", message: "Could not save. \(error), \(error.userInfo)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        self.navigationController?.popViewController(animated: true)
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
