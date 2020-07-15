//
//  RegisterViewController.swift
//  MagicWallet
//
//  Created by Denis Janoto on 08/07/20.
//  Copyright © 2020 Denis Janoto. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRepeatPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        configTxtField()
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
    
    //MARK: - CONFIG TEXFIELD
    func configTxtField(){
        
        txtName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtRepeatPassword.delegate = self
        
        //change return keyboard button title to 'next' and 'done'
        txtName.returnKeyType = .next
        txtEmail.returnKeyType = .next
        txtPassword.returnKeyType = .next
        txtRepeatPassword.returnKeyType = .done
        
        //add space before firt character
        txtName.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        txtEmail.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        txtPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        txtRepeatPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        
    }
    
    
    //MARK: - CHANGE TEXTFIELD FOCUS WITH 'NEXT' KEYBOARD BUTTON
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName {
            txtEmail.becomeFirstResponder()
        }else if textField == txtEmail{
            txtPassword.becomeFirstResponder()
            
        }else if textField == txtPassword{
            txtRepeatPassword.becomeFirstResponder()
            
        }else if textField == txtRepeatPassword{
            view.endEditing(true)
        }
        return true
    }
    
    
    //MARK: - TOUCH SCREEN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    
    //MARK: - REGISTER BUTTON
    @IBAction func btnRegister(_ sender: Any) {
        if txtName.text!.isEmpty{
            showAlert(isSussess: false, title: "Campo Vazio!", message: "O campo Nome deve ser preenchido.")
        }else if txtEmail.text!.isEmpty{
            showAlert(isSussess: false, title: "Campo Vazio!", message: "O campo Email deve ser preenchido.")
        }else if txtPassword.text!.isEmpty{
            showAlert(isSussess: false, title: "Campo Vazio!", message: "O campo Senha deve ser preenchido.")
        }else if txtRepeatPassword.text!.isEmpty{
            showAlert(isSussess: false, title: "Campo Vazio!", message: "O campo Repetir Senha deve ser preenchido.")
        }else if txtPassword.text != txtRepeatPassword.text{
            showAlert(isSussess: false, title: "Verifique sua senha!", message: "Os campos de senha não coincidem.")
            
        }else{
            //create new user
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (authResult, error) in
                if error == nil{
                    self.showAlert(isSussess: true, title: "Seja bem vindo!", message: "Seu cadastro foi realizado com sucesso.")
                }else{
                    self.showAlert(isSussess: false, title: "Erro ao cadastrar usuário!", message: "Por favor, tente realizar o cadastro novamente.")
                }
            }
        }
    }
    
    //MARK: -  CREATE AND SHOW ALERT
    func showAlert(isSussess:Bool, title:String,message:String){
        var alertTitle:String = ""
        var alertMessage:String = ""
        
        alertTitle = title
        alertMessage = message
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (action) in
            if isSussess{
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
