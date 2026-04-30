//
//  PerfilViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 28/04/26.
//

import UIKit
import FirebaseAuth

class PerfilViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
  
    
    @IBOutlet weak var correoLabel: UILabel!
    
    
    @IBOutlet weak var telefonoLabel: UILabel!
    
    
    @IBOutlet weak var direccionLbel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatos()
        

        // Do any additional setup after loading the view.
    }
    
    
    func cargarDatos() {
            nombreLabel.text = UserDefaults.standard.string(forKey: "nombres") ?? ""
            correoLabel.text = UserDefaults.standard.string(forKey: "correo") ?? ""
            telefonoLabel.text = UserDefaults.standard.string(forKey: "numero") ?? ""
            direccionLbel.text = UserDefaults.standard.string(forKey: "direccion") ?? ""
        }
    
    @IBAction func cerrar(_ sender: UIButton) {
        openAlert()

}

    func openAlert() {
         let alert = UIAlertController(
             title: "¿Estás seguro de cerrar sesión?",
             message: "Todos tus datos serán eliminados",
             preferredStyle: .alert
         )

         let actionAceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in
             
             let firebaseAuth = Auth.auth()
             
             do {
                 try firebaseAuth.signOut()
                 
                 // 🔹 Limpiar estado de login
                 UserDefaults.standard.set(false, forKey: "login")
                 
                 self.navigationController?.popToRootViewController(animated: true)
                 
             } catch let signOutError as NSError {
                 print("Error al cerrar sesión: %@", signOutError)
             }
         }

         let actionCancelar = UIAlertAction(title: "Cancelar", style: .cancel)

         alert.addAction(actionAceptar)
         alert.addAction(actionCancelar)

         present(alert, animated: true)
     }
}
