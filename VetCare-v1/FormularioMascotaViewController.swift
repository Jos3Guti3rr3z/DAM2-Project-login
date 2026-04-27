//
//  FormularioMascotaViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 22/04/26.
//

protocol FormularioMascotaDelegate: AnyObject {
    func agregarMascota(_ mascota: MascotaVM)
}

import UIKit

class FormularioMascotaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    weak var delegate: FormularioMascotaDelegate?
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    @IBAction func seleccionarImagen(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let imagen = info[.editedImage] as? UIImage {
            imagenMascota.image = imagen
        } else if let imagen = info[.originalImage] as? UIImage {
            imagenMascota.image = imagen
        }

        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    
    @IBAction func guardarMascota(_ sender: Any) {
        print("💾 BOTÓN GUARDAR PRESIONADO")
        
        let mascota = MascotaVM(
                nombre: txtNombreMascota.text ?? "",
                especie: txtEspecieMascota.text ?? "",
                raza: txtRazaMascota.text ?? "",
                peso: txtPesoMascota.text ?? "",
                edad: txtEdadMascota.text ?? "",
                sexo: txtSexoMascota.text ?? "",
                alergias: txtAlergiasMascota.text ?? "",
                imagen: imagenMascota.image
            )

        print("📦 MASCOTA CREADA:", mascota.nombre)
        
            delegate?.agregarMascota(mascota)

            navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var txtNombreMascota: UITextField!
    
    @IBOutlet weak var txtEspecieMascota: UITextField!
    
    @IBOutlet weak var txtRazaMascota: UITextField!
    
    @IBOutlet weak var imagenMascota: UIImageView!
    
    @IBOutlet weak var txtPesoMascota: UITextField!
    
    @IBOutlet weak var txtEdadMascota: UITextField!
    
    @IBOutlet weak var txtSexoMascota: UITextField!
    
    @IBOutlet weak var txtAlergiasMascota: UITextField!
    
    
   
}
