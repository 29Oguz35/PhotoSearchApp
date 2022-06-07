//
//  ViewController.swift
//  Photo Seach
//
//  Created by naruto kurama on 26.04.2022.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
  
    var results : [Result] = []
    
    private var collectionView : UICollectionView?
    
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width/2, height: view.frame.width/2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        getPhotos(query: "office")
    }
    override func viewDidLayoutSubviews() {
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width-20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.frame.size.width, height: view.frame.size.height - 55)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if let txt = searchBar.text {
            results = []
            collectionView?.reloadData()
            getPhotos(query: txt)
        }
    }
    func getPhotos(query : String) {
        let urlString = "https://api.unsplash.com/search/photos?page=3&per_page=50&query=\(query)&client_id=HYFRYQ8EGAmwkOEZWH6yRY21wfzYI1cgIt-jjZunuQg"
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
               
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView?.reloadData()
                }
            }catch {
                print(error)
            }
        }
        task.resume()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageURLString = results[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as?
                ImageCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: imageURLString)
        return cell
    }

}

