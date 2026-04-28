//
//  RegisterViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 28/04/26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var nombresText: UITextField!
    @IBOutlet weak var numeroText: UITextField!
    @IBOutlet weak var direccionText: UITextField!
    @IBOutlet weak var correoText: UITextField!
    @IBOutlet weak var claveText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register(_ sender: Any) {
        let nombres = nombresText.text ?? ""
        let numero = numeroText.text ?? ""
        let direccion = direccionText.text ?? ""
        let correo = correoText.text ?? ""
        let clave = claveText.text ?? ""
        
        registerFirebase(nombres: nombres, numero: numero, direccion: direccion, correo: correo, clave: clave)
        
    }
    
    private func registerFirebase(nombres: String, numero: String, direccion: String, correo: String, clave: String) {
        let auth = Auth.auth()
        auth.createUser(withEmail: correo, password: clave) { (result, error) in
            if let error = error {
                print(error.self)
            } else if let result = result {
                print("Usuario creado")
                let uid = result.user.uid
                self.registerFirestore(uid: uid, nombres: nombres, numero: numero, direccion: direccion, correo: correo)
            }
        }
    }
    
    private func registerFirestore(uid: String, nombres: String, numero: String, direccion: String, correo: String) {
        let db = Firestore.firestore()
        db.collection("usuarios").document(uid).setData([
            "nombres": nombres,
            "numero": numero,
            "direccion": direccion,
            "correo": correo
        ]) {error in
            if let error = error {
                print(error.self)
            } else {
                print("Datos guardados")
                self.dismiss(animated: true)
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
