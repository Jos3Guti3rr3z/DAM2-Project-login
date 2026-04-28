//
//  SceneDelegate.swift
//  VetCare-v1
//
//  Created by XCODE on 15/04/26.
//

import UIKit
import FirebaseAuth // No olvides importar esto

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 1. Inicializamos la ventana manualmente
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        // 2. Escuchamos cambios en la autenticación de Firebase
        // Esto se ejecuta al abrir la app y cada vez que el usuario haga login/logout
        Auth.auth().addStateDidChangeListener { (auth, user) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if user != nil {
                // Hay sesión activa en Firebase
                let vc = storyboard.instantiateViewController(withIdentifier: "menuView")
                window.rootViewController = vc
            } else {
                // No hay sesión (o acaba de cerrar sesión)
                // Aquí pones el ID de tu pantalla de Login
                let loginVC = storyboard.instantiateViewController(withIdentifier: "loginView")
                window.rootViewController = loginVC
            }
            
            // 3. Mostramos la ventana con una pequeña animación
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            window.makeKeyAndVisible()
        }
    }
    
    // El método validateLogin ya no es necesario si usas el listener de arriba,
    // ya que 'user != nil' hace ese trabajo por ti de forma más segura.
}

