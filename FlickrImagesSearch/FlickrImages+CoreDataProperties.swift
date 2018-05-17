//
//  FlickrImages+CoreDataProperties.swift
//  FlickrImagesSearch
//
//  Created by Oussama Ayed on 17/05/2018.
//  Copyright © 2018 Oussama Ayed. All rights reserved.
//
//

import Foundation
import CoreData


extension FlickrImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlickrImages> {
        return NSFetchRequest<FlickrImages>(entityName: "FlickrImages")
    }

    @NSManaged public var urlImage: String?

}
