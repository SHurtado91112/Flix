//
//  ExpandViewController.swift
//  Flix
//
//  Created by Steven Hurtado on 2/3/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import FloatRatingView

class ExpandViewController: UIViewController {

    @IBOutlet var expandCover: UIImageView!
    var coverImage: UIImage = UIImage()
    
    @IBOutlet var movieLabel: UILabel!
    var movieTitle: String = String()
    
    @IBOutlet var rater: FloatRatingView!
    var rating: Double = 0.0
    
    @IBOutlet var genreLabel: UILabel!
    var genreText: String = String()
    
    @IBOutlet var descriptionView: UITextView!
    var descriptionText: String = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        rater.emptyImage = UIImage(named: "Rating-50")?.withRenderingMode(.alwaysTemplate)
        rater.fullImage = UIImage(named: "Rating Filled-50")?.withRenderingMode(.alwaysTemplate)
        rater.tintColor =  UIColor(red: 0.0/255.0,
                                   green:  122.0/255.0,
                                   blue: 255.0/255.0,
                                   alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        expandCover.image = coverImage
        movieLabel.text = movieTitle
        rater.rating = Float(Double(rating/2.0))
        genreLabel.text = genreText
        descriptionView.text = descriptionText
    }
    @IBAction func closeMe(_ sender: Any)
    {
        self.view.alpha = 1
        
        UIView.animate(withDuration: 0.3)
        {
            self.view.alpha = 0
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.removeSelf), userInfo: nil, repeats: false)
        }
    }
    
    func removeSelf(_:Timer)
    {
        self.view.removeFromSuperview()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
