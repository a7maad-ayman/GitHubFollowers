//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Ahmad Ayman Mansour on 14/05/2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let avatarPlaceholder = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = avatarPlaceholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //Sean Allen -> recommendation to put it here out off Network Manager because it has no error handling and we don't have to handle errors here
    func downloadImage(from stringUrl: String){
        
        let cacheKey = NSString(string: stringUrl)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: stringUrl) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response , error in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKey)
            
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
