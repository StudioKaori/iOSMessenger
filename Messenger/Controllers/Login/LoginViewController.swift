//
//  LoginViewController.swift
//  Messenger
//
//  Created by Kaori Persson on 2022-05-31.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.placeholder = "Email Address..."
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
       let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.placeholder = "Password..."
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
      let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    // FB login
    private let fbLoginButton = FBLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister) )
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        emailField.delegate = self
        passwordField.delegate = self
        
        // add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(fbLoginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        // image size will be squire. to center the image, divide by 2
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        loginButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width-60,
                                   height: 52)
        fbLoginButton.frame = CGRect(x: 30,
                                     y: loginButton.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)

    }
    
    // MARK: - login button tapped
    @objc func loginButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        // firebase login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            
            guard let strongSelf = self else {
                return
            }

            guard let result = authResult, error == nil else {
                print("Error: log in")
                return
            }
            
            let user = result.user
            print("Loggin user: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to log in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

extension LoginViewController: UITextFieldDelegate {
    
    // when user hit the Enter in the text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        // if it's password, call loginButtonTapped
        else if textField == passwordField {
            loginButtonTapped()
        }
        
        return true
    }
    
}
