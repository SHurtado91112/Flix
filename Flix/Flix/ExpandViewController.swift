//
//  ExpandViewController.swift
//  Flix
//
//  Created by Steven Hurtado on 2/3/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import FloatRatingView

class ExpandViewController: UIViewController, UIScrollViewDelegate
{

    @IBOutlet var expandCover: UIImageView!
    var coverImage: UIImage = UIImage()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var movieLabel: UILabel!
    var movieTitle: String = String()
    
    @IBOutlet weak var scrollButton: UIButton!
    var scrolled: Bool = false
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet var rater: FloatRatingView!
    var rating: Double = 0.0
    
    @IBOutlet var genreLabel: UILabel!
    var genreText: String = String()
    
    @IBOutlet var descriptionView: UITextView!
    var descriptionText: String = String()
    
    var movieID : Int = 0
    var movieTrailer : String = ""
    var movieDate : String = ""
    
    @IBOutlet weak var trailerBtn: UIButton!
    
    @IBOutlet weak var calendarImgView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.scrollView?.delegate = self
        
        calendarImgView.image = UIImage(named: "Calendar Filled-50")?.withRenderingMode(.alwaysTemplate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateObj = formatter.date(from: movieDate)
        formatter.dateFormat = "MMM dd, yyyy"
        
        dateLabel.text = String(describing: formatter.string(from: dateObj!))
        
        expandCover.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.height)
        
        trailerRequest()
        
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
    
    func trailerRequest()
    {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)&language=en-US")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data
            {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                {
                    let trailerArray = dataDictionary["results"] as! [NSDictionary]
                    let trailerDictionary = trailerArray[0]
                    let trailer = trailerDictionary["key"] as! String
                
                    self.movieTrailer = "https://www.youtube.com/embed/\(trailer)"
                    print(self.movieTrailer)
                }
            }
            else
            {
                print("\nDATA ERROR\n")
            }
        }
        task.resume()
    }
    
    @IBAction func trailerPressed(_ sender: Any)
    {
        self.performSegue(withIdentifier: "trailerSegue", sender: self)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if(scrollView.contentOffset == CGPoint(x: 0.0, y: 0.0))
        {
            self.scrollButton.setImage(UIImage(named: "Up Squared Filled-50")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.scrolled = false
        }
        else if(scrollView.contentOffset == CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom))
        {
            self.scrollButton.setImage(UIImage(named: "Down Squared Filled-50")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.scrolled = true
        }
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
    
    @IBAction func scrollToggle(_ sender: Any)
    {
     
        let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom)
        
        let backOffset = CGPoint(x: 0.0, y: 0.0)
        
        if(!scrolled)
        {
            self.scrollButton.setImage(UIImage(named: "Down Squared Filled-50")?.withRenderingMode(.alwaysTemplate), for: .normal)
            
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            
            self.scrolled = true
        }
        else
        {
            self.scrollButton.setImage(UIImage(named: "Up Squared Filled-50")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.scrollView.setContentOffset(backOffset, animated: true)

            self.scrolled = false
        }
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "trailerSegue")
        {
            let vc = segue.destination as! embedWebViewController
            
            vc.embedURL = self.movieTrailer
        }
       
    }

}

