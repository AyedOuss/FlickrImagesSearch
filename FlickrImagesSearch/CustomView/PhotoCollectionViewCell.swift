//
//  PhotoCollectionViewCell.swift
//  FlickrImagesSearch
//
//  Created by Oussama Ayed on 17/05/2018.
//  Copyright © 2018 Oussama Ayed. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    func setUp(with photo:Photo) -> Void {
        if let url = photo.url {
            photoImageView.layer.cornerRadius = 10.0

            photoImageView?.kf.setImage(with: URL(string: url))
        }
    }
    
}

