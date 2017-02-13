//
//  MovieCell.swift
//  Flix
//
//  Created by Steven Hurtado on 1/30/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell
{
    @IBOutlet var movieLabel: UILabel!
    @IBOutlet var movieCover: UIImageView!
    
    var movieGenre : String = ""
    var movieDescription : String = ""
    var rateGiven : Double = 0.0
    var movieID : Int = 0
    var movieDate : String = ""
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0.0, height: 14.0)
        self.layer.shadowRadius = 10
        self.layer.shouldRasterize = true
    }
}
