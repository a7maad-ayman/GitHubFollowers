//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Ahmad Ayman Mansour on 01/05/2023.
//

import UIKit


 class SearchViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let getFollowersButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUsernameEntered: Bool { return !userNameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureUserNameTextField()
        configureGetFollowersButton()
        createGestureToDissmissKeyboard()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                        //.navigationBar.isHidden = true
                        //.isNavigationBarHidden  = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createGestureToDissmissKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please Enter a user name. we need to know who to look for 😄", buttonTitle: "OK")
            return
        }
        let followerListVC = FollowerListViewController()
        followerListVC.username = userNameTextField.text
        followerListVC.title    = userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureUserNameTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureGetFollowersButton(){
        view.addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.pushFollowerListVC()
        return true
    }
}
