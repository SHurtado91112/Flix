//
//  ViewController.swift
//  Flix
//
//  Created by Steven Hurtado on 1/30/17.
//  Copyright © 2017 Steven Hurtado. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
import CircularSpinner

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate
{
    @IBOutlet var searchBar: UISearchBar!

    var filteredData: [NSDictionary]? = []
    var keyValGenre : [Int : String] = [:]
    
    @IBOutlet var collectionView: UICollectionView!
    
    var moviesDictionary : [NSDictionary]? = []
    
    @IBOutlet var networkErrorBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        self.collectionView.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:))))
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white,
             NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 24)!]
        
        
        self.networkErrorBtn.alpha = 0
        self.networkErrorBtn.imageView?.contentMode = .scaleAspectFit
        self.networkErrorBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 0.0/255.0,
                                           green:  122.0/255.0,
                                           blue: 255.0/255.0,
                                           alpha: 1)
        //call for api request
        
        genreRequest()
        
        apiRequest()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
    
        return self.filteredData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movie", for: indexPath) as! MovieCell
        
        let movie = filteredData![indexPath.row]
        let title = movie["title"] as! String
        let descriptionText = movie["overview"] as! String
        let genreArr = movie["genre_ids"] as! [Int]
        let rate = movie["vote_average"] as! Double
        
        let posterPath = movie["poster_path"] as! String
        let base = "https://image.tmdb.org/t/p/w342"
        
        let imageURL = NSURL(string: base + posterPath)
        
        cell.movieLabel.text = title
        
        let imageRequest = NSURLRequest(url: imageURL as! URL)
        
        cell.movieCover.setImageWith(
            imageRequest as URLRequest,
            placeholderImage: nil,
            success: { (imageRequest, imageResponse, image) -> Void in
                
                // imageResponse will be nil if the image is cached
                if imageResponse != nil
                {
                    cell.movieCover.alpha = 0.0
                    cell.movieCover.image = image
                    cell.movieDescription = descriptionText
                    cell.rateGiven = rate
                    cell.movieGenre = ""
                    
                    if(genreArr.count > 0)
                    {
                        for i in 0...genreArr.count-1
                        {
                            if(i < genreArr.count-1)
                            {
                                cell.movieGenre += "\(self.keyValGenre[genreArr[i]]!), "
                            }
                            else
                            {
                                cell.movieGenre += "\(self.keyValGenre[genreArr[i]]!)"
                            }
                            
                        }
                    }
                    

                    UIView.animate(withDuration: 0.7, animations: { () -> Void in
                        cell.movieCover.alpha = 1.0
                    })
                } else {
                    cell.movieCover.image = image
                    cell.movieDescription = descriptionText
                    cell.rateGiven = rate
                    
                    cell.movieGenre = ""
                    
                    for i in 0...genreArr.count-1
                    {
                        if(i < genreArr.count-1)
                        {
                            cell.movieGenre += "\(self.keyValGenre[genreArr[i]]!), "
                        }
                        else
                        {
                            cell.movieGenre += "\(self.keyValGenre[genreArr[i]]!)"
                        }
                    }
                }
        },
            failure: { (imageRequest, imageResponse, error) -> Void in
                // do something for the failure condition
        })
 
        return cell
    }

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? moviesDictionary : moviesDictionary?.filter({(dataDictionary: NSDictionary) -> Bool in
            // If dataItem matches the searchText, return true to include it
            let dataString = dataDictionary["title"] as! String
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonPressed(searchBar: UISearchBar!)
    {
        self.searchBar.resignFirstResponder()
    }
    
    func genreRequest()
    {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data
            {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                {
                    let emptyDictionary = dataDictionary["genres"] as! [NSDictionary]
                    
                    for i in 0...emptyDictionary.count-1
                    {
                        let id = emptyDictionary[i]["id"] as! Int
                        let genre = emptyDictionary[i]["name"] as! String
                        self.keyValGenre[id] = genre
//                        print("ID: \"\(id)\" => \(keyValGenre[id]!)")
                    }
                    
                }
            }
            else
            {
                print("\nDATA ERROR\n")
            }
        }
        
        self.collectionView.reloadData()
        
        task.resume()

    }
    
    func apiRequest()
    {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        CircularSpinner.trackBgColor = UIColor(red: 0.0/255.0,
                                               green:  122.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 0)
        CircularSpinner.trackPgColor = UIColor(red: 0.0/255.0,
                                               green:  122.0/255.0,
                                               blue: 255.0/255.0,
                                               alpha: 1)
        CircularSpinner.show("Grabbing flix...", animated: true, type: .indeterminate)
        

        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data
            {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                {

                    self.moviesDictionary = dataDictionary["results"] as? [NSDictionary]
//                    print("\(self.moviesDictionary)")
                    
                    self.filteredData = self.moviesDictionary
                    
                    CircularSpinner.hide()

                    self.collectionView.reloadData()
                    
                    if(self.networkErrorBtn.alpha == 1)
                    {
                        self.animateViews()
                    }
                }
            }
            else
            {
                self.networkError()
            }
        }
        task.resume()
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(_ refreshControl: UIRefreshControl)
    {
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data
            {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                {
                    
                    self.moviesDictionary = dataDictionary["results"] as? [NSDictionary]
                    self.filteredData = self.moviesDictionary
                    self.collectionView.reloadData()
                    if(self.networkErrorBtn.alpha == 1)
                    {
                        self.animateViews()
                    }
                }
            }
            else
            {
                if(self.networkErrorBtn.alpha == 0)
                {
                    self.networkError()
                }
            }
        }
        task.resume()
        
        refreshControl.endRefreshing()
    }
    
    @IBAction func errorBtnPressed(_ sender: Any)
    {
        apiRequest()
    }
    
    func networkError()
    {
        
        if(self.networkErrorBtn.alpha == 0)
        {
            self.animateViews()
        }
        CircularSpinner.hide()
    }
    
    func animateViews()
    {
   
        if(self.networkErrorBtn.alpha == 0)
        {
            UIView.animate(withDuration: 0.4, animations: {
                self.networkErrorBtn.alpha = 1
                self.collectionView.alpha = 0
            })
        }
        else
        {
            UIView.animate(withDuration: 0.4, animations: {
                self.networkErrorBtn.alpha = 0
                self.collectionView.alpha = 1
            })
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let VC = storyboard?.instantiateViewController(withIdentifier: "popController") as! ExpandViewController
        
        print("Cell for indexPath: \(indexPath.row)")
        
        let cellInfo = collectionView.cellForItem(at: indexPath) as! MovieCell
        
        VC.coverImage = cellInfo.movieCover.image!
        VC.movieTitle = cellInfo.movieLabel.text!
        VC.genreText = cellInfo.movieGenre
        VC.descriptionText = cellInfo.movieDescription
        VC.rating = cellInfo.rateGiven
        
//        let pop = nav.popoverPresentationController
//        pop?.delegate = self
//        pop?.sourceView = cellInfo
        
        VC.view.alpha = 0
        //VC.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.addChildViewController(VC)
        
        VC.view.frame = self.view.frame
        self.view.addSubview(VC.view)
        VC.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.3)
        {
            VC.view.alpha = 1
            //VC.view.transform = CGAffineTransform.identity
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .none
    }
    
    func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        self.searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
//        if(segue.identifier == "popSegue")
//        {
//            
//            let cellInfo : MovieCell = sender as! MovieCell
//            
//            print("Popped: \(cellInfo.tag)")
//            
//            if let destination = segue.destination as? ExpandViewController
//            {
//                //print(destination.expandCover)
//                //print(cellInfo.movieCover)
//                destination.coverImage = cellInfo.movieCover.image!
//                destination.movieTitle = cellInfo.movieLabel.text!
//                destination.genreText = cellInfo.movieGenre
//                destination.descriptionText = cellInfo.description
//            }
//        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

