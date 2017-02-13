//
//  MovieTopCell.swift
//  Flix
//
//  Created by Steven Hurtado on 2/12/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit

class MovieTopCell: UICollectionViewCell
{

    
    @IBOutlet weak var movieCover: UIImageView!
    
    @IBOutlet weak var movieLabel: UILabel!
    
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
        self.layer.shadowOffset = CGSize(width: 0.0, height: 24.0)
        self.layer.shadowRadius = 10
        self.layer.shouldRasterize = true
    }

}
