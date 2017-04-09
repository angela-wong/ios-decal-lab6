//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    var label: UILabel = {
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                            width: UIScreen.main.bounds.width,
                                            height: 300) )
        
        // configure the text of the button
        myLabel.text = "Login View Controller"
        myLabel.font = UIFont(name: "Avenir", size: 60)
        myLabel.numberOfLines = 2
        myLabel.textAlignment = .center
        myLabel.textColor = .white
        myLabel.backgroundColor = Constants.backgroundColor
        return myLabel
    }()
    
    var theView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .white
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = true
        return myView
    }()
    
    var email: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.text = "berkeley.edu account"
        txt.font = UIFont(name: "avenir", size: 18)
        txt.textAlignment = .left
        txt.textColor = .gray
        return txt
    }()
    
    var password: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.text = "Password"
        txt.font = UIFont(name: "avenir", size: 18)
        txt.textAlignment = .left
        txt.textColor = .gray
        return txt
    }()
    
    var login: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 18)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.backgroundColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    // TODO: instantiate the views needed for your project
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(label)
        view.addSubview(theView)
        theView.addSubview(email)
        theView.addSubview(password)
        theView.addSubview(login)
        theView.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        login.translatesAutoresizingMaskIntoConstraints = false
        let viewWidth: CGFloat = view.frame.width * 0.9
        let myConstraints = [
            
            theView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            theView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            theView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: view.frame.width*0.05),
            //theView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
               //                               constant: view.frame.width*0.05),
            theView.widthAnchor.constraint(equalToConstant: viewWidth),
            theView.heightAnchor.constraint(equalToConstant: 185),
            email.centerXAnchor.constraint(equalTo: theView.centerXAnchor),
            login.centerXAnchor.constraint(equalTo: theView.centerXAnchor),
            password.centerXAnchor.constraint(equalTo: theView.centerXAnchor),
            email.leadingAnchor.constraint(equalTo: theView.leadingAnchor,
                                            constant: 15),
            password.leadingAnchor.constraint(equalTo: theView.leadingAnchor,
                                             constant: 15),
            login.leadingAnchor.constraint(equalTo: theView.leadingAnchor,
                                             constant: 70),
            email.trailingAnchor.constraint(equalTo: theView.trailingAnchor,
                                              constant: 15),
            password.trailingAnchor.constraint(equalTo: theView.trailingAnchor,
                                              constant: 15),
            login.trailingAnchor.constraint(equalTo: theView.trailingAnchor,
                                              constant: -70),
            email.widthAnchor.constraint(equalToConstant: theView.frame.width*0.9),
            password.widthAnchor.constraint(equalToConstant: theView.frame.width*0.9),
            login.widthAnchor.constraint(equalToConstant: theView.frame.width-140),
            email.heightAnchor.constraint(equalToConstant: 20),
            password.heightAnchor.constraint(equalToConstant: 20),
            login.heightAnchor.constraint(equalToConstant: 60),
            email.topAnchor.constraint(equalTo: theView.topAnchor, constant: 20),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            
            login.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            login.bottomAnchor.constraint(equalTo: theView.bottomAnchor, constant: -20),
            
        ]
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        // TODO: layout your views using frames or AutoLayout
        NSLayoutConstraint.activate(myConstraints)
        login.addTarget(self, action: #selector(checkLogin), for: .touchDown)
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func checkLogin(sender: UIButton) {
        authenticateUser(username: email.text, password: password.text)
    }
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
