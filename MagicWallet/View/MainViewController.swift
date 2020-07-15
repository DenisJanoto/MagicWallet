//
//  MainViewController.swift
//  MagicWallet
//
//  Created by Denis Janoto on 10/07/20.
//  Copyright © 2020 Denis Janoto. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var lblValorAdicionado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configFireBase()
        configTextField()
        configTabbar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureLabel()
        
    }
    
    
    
    
    //MARK: - CONFIG FIREBASE
    var UIDloggedUser:String?
    func configFireBase(){
        
        //get email from logged user
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.UIDloggedUser = user?.uid
        }
        
        
        
    }
    
    
    //MARK: - CONFIG TABBAR
    func configTabbar(){
        //change tabbar color
        UITabBar.appearance().barTintColor = UIColor(named: "tabbar-color")
        tabBarController?.tabBar.isTranslucent = false
    }
    
    
    //MARK: - CONFIG TEXFIELD
    func configTextField(){
        //change placeholder color
        txtValue.attributedPlaceholder = NSAttributedString(string: "R$0,00",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "textfiled-font-main-screen") ?? UIColor.white])
    }
    
    //MARK: - CONFIG LABEL
    func configureLabel(){
        lblValorAdicionado.isHidden = true
    }
    
    
    //MARK: - ADD VALUE BUTTON
    @IBAction func addValueButton(_ sender: Any) {
        
        let date = Date()
        let calendar = Calendar.current
        
        //current week number from mounth
        let currenMounthtWeek = calendar.component(.weekOfMonth, from: Date())
        
        //current mounth number from year
        let mounth = calendar.component(.month, from: date)
        
        //save firebase data
        let reference = Database.database().reference()
        reference.child(UIDloggedUser!).child("mes\(mounth)").child("semana\(currenMounthtWeek)").childByAutoId().setValue(txtValue.text)
        
        //clean textfield
        txtValue.text = ""
         
        //show label message 'Valor Adicionado' for 6 seconds and hide again
        self.lblValorAdicionado.isHidden = false
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
            self.lblValorAdicionado.isHidden = true
        }
        
        
        
        
    }
    
    
    //MARK: - STATISTICS BUTTON
    @IBAction func statisticsButton(_ sender: Any) {
    }
    
}
