//
//  PerfilViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 28/04/26.
//

import UIKit
import FirebaseAuth

class PerfilViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cerrar(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                
                // Regresar a la pantalla de Login o Welcome
                // Ejemplo: Si usas un Navigation Controller
                UserDefaults.standard.bool(forKey: "login")
                self.navigationController?.popToRootViewController(animated: true)
                
            } catch let signOutError as NSError {
                print("Error al cerrar sesión: %@", signOutError)
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
