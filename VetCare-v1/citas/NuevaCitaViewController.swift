//
//  NuevaCitaViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 29/04/26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

// Este protocolo es el "contrato" para enviar la información de vuelta
protocol NuevaCitaDelegate: AnyObject {
    func agregarNuevaCita(_ cita: Cita)
}

class NuevaCitaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Outlets
    // Asegúrate de conectar estos en el Storyboard
    @IBOutlet weak var txtNombreMascota: UITextField!
    @IBOutlet weak var txtNombreDueño: UITextField!
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var txtHora: UITextField!
    @IBOutlet weak var txtMotivo: UITextField!
    
    weak var delegate: NuevaCitaDelegate?

       // 🔹 Data
       var mascotas: [String] = []
       let picker = UIPickerView()

       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Configurar picker
           picker.delegate = self
           picker.dataSource = self
           
           txtNombreMascota.inputView = picker
           
           // 🔹 Autocompletar dueño con el correo guardado
               let duenio = UserDefaults.standard.string(forKey: "correo") ?? ""
               txtNombreDueño.text = duenio
               
               cargarMascotas()
       }

       // 🔹 Obtener mascotas desde Firestore
    func cargarMascotas() {
        let db = Firestore.firestore()
        
        // 🔹 obtenemos el dueño desde UserDefaults
        let duenio = UserDefaults.standard.string(forKey: "correo") ?? ""
        
        db.collection("mascotas")
          .whereField("duenio", isEqualTo: duenio)
          .getDocuments { snapshot, error in
              
              if let error = error {
                  print("Error: \(error.localizedDescription)")
                  return
              }

              self.mascotas.removeAll()

              snapshot?.documents.forEach { doc in
                  let nombre = doc["nombre"] as? String ?? ""
                  self.mascotas.append(nombre)
              }

              print("Mascotas cargadas: \(self.mascotas)") // DEBUG
              
              self.picker.reloadAllComponents()
          }
    }

       // 🔹 Picker
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return mascotas.count
       }

       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return mascotas[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           txtNombreMascota.text = mascotas[row]
       }

       // MARK: - Guardar
       @IBAction func btnGuardarCitaPresionado(_ sender: UIButton) {
           
           guard let mascota = txtNombreMascota.text, !mascota.isEmpty,
                 let dueno = txtNombreDueño.text, !dueno.isEmpty else {
               
               let alerta = UIAlertController(title: "Error", message: "Por favor llena los campos principales", preferredStyle: .alert)
               alerta.addAction(UIAlertAction(title: "OK", style: .default))
               present(alerta, animated: true)
               return
           }

           let nuevaCita = Cita(
               nombreMascota: mascota,
               nombreDueño: dueno,
               fecha: txtFecha.text ?? "",
               hora: txtHora.text ?? "",
               motivo: txtMotivo.text ?? ""
           )

           delegate?.agregarNuevaCita(nuevaCita)
           navigationController?.popViewController(animated: true)
       }
   }

