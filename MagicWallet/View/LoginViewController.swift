//
//  LoginViewController.swift
//  MagicWallet
//
//  Created by Denis Janoto on 08/07/20.
//  Copyright © 2020 Denis Janoto. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTxtField()
    }
    
    
    //MARK: - CONFIG TEXFIELD
    func configTxtField(){
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        //change return keyboard button title to 'next' and 'done'
        txtEmail.returnKeyType = .next
        txtPassword.returnKeyType = .done
        
        //add space before firt character
        txtEmail.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        txtPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 10)
        
    }
    
    //MARK: - CHANGE TEXTFIELD FOCUS WITH KEYBOARD BUTTON
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }else if textField == txtPassword{
            view.endEditing(true)
        }
        return true
    }
    
    
    //MARK: - TOUCH SCREEN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - LOGIN BUTTON
    @IBAction func btnLogin(_ sender: Any) {
        if txtEmail.text!.isEmpty{
            self.showAlert(isSussess: false, title: "Campo Vazio!", message: "O campo Email deve ser preenchido")
        }else if txtPassword.text!.isEmpty {
            self.showAlert(isSussess: false, title: "Campo Vazio!", message: "O campo Senha deve ser preenchido")
        }else{
            let auth:Auth!
            auth = Auth.auth()
            auth.signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (usuario, erro) in
                if erro == nil{
                    
                    
                    
                }else{
                    self.showAlert(isSussess: false, title: "Erro ao logar!", message: "Houve algum erro ao realizar o login. Tente Novamente")
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
