//
//  LoginViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 27/04/26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {

    @IBOutlet weak var correoText: UITextField!
    @IBOutlet weak var claveText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        let correo = correoText.text ?? ""
        let clave = claveText.text ?? ""
        
        Auth.auth().signIn(withEmail: correo,
                           password: clave) { (authResult, error) in
            // authResult != null - login correcto
            // error != null - login incorrecto
            if let result = authResult {
                let uid = result.user.uid
                print("El usuario con uid: se ha logueado")
                self.searchFirestore(uid: uid)
               
            } else {
                print("Error al intentar loguearse")
            }
            
        }
    }
    
    private func searchFirestore(uid: String) {
        let db = Firestore.firestore()
        let ref = db.collection("usuarios").document(uid)
        ref.getDocument{ (document, error) in
            if let document = document, document.exists {
                print("Document data: \(document.data()!)")
                
                let nombres = document.data()!["nombres"] as! String
                let numero = document.data()!["numero"] as! String
                let direccion = document.data()!["direccion"] as! String
                let correo = document.data()!["correo"] as! String
                
                self.saveDefaults(nombres: nombres, numero: numero, direccion: direccion, correo: correo)
            } else {
                print("Document does not exists")
            }
        }
    }
    
    private func saveDefaults(nombres: String, numero: String, direccion: String, correo: String) {
        UserDefaults.standard.set(nombres, forKey: "nombres")
        UserDefaults.standard.set(numero, forKey: "numero")
        UserDefaults.standard.set(direccion, forKey: "direccion")
        UserDefaults.standard.set(correo, forKey: "correo")
        UserDefaults.standard.set(true, forKey: "login")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "menuView")
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
        
    }
    


}
