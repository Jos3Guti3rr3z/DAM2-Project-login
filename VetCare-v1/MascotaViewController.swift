//
//  MascotaViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 22/04/26.
//

import UIKit
import FirebaseFirestore

class MascotaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mascotas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mascotaCell", for: indexPath) as! MascotaTableViewCell

                let mascota = mascotas[indexPath.row]

                cell.nombreMascotaLabel.text = mascota.nombre
                cell.especieMascotaLabel.text = mascota.especie
                cell.edadMascotaLabel.text = mascota.edad

                cell.fotoMascotImage.image = mascota.imagen

                return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        print("🧪 Swipe detectado")
        
        if editingStyle == .delete {
            let mascota = mascotas[indexPath.row]
            eliminarMascota(id: mascota.id)
        }
    }

    var mascotas: [MascotaVM] = []
    

    @IBOutlet weak var tableViewMascota: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("🔥 viewDidLoad MascotaViewController")
        
        tableViewMascota.dataSource = self
        tableViewMascota.delegate = self
        
        self.obtenerMascotas()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("🚀 SE EJECUTÓ SEGUE:", segue.identifier ?? "sin id")
            
            if segue.identifier == "irFormulario" {
                let destino = segue.destination as! FormularioMascotaViewController
                destino.delegate = self
                print("✅ DELEGATE ASIGNADO")
            }
        }
    
    func obtenerMascotas() {
        let correo = UserDefaults.standard.string(forKey: "correo") ?? "sin_correo"
        print(correo)
        
        db.collection("mascotas")
            .whereField("duenio", isEqualTo: correo)
            .getDocuments { snapshot, error in
                
                if let error = error {
                    print("❌ Error:", error.localizedDescription)
                    return
                }

                guard let documentos = snapshot?.documents else { return }

                self.mascotas.removeAll()

                for doc in documentos {
                    let data = doc.data()

                    let mascota = MascotaVM(
                        id: doc.documentID,
                        nombre: data["nombre"] as? String ?? "",
                        especie: data["especie"] as? String ?? "",
                        raza: data["raza"] as? String ?? "",
                        peso: data["peso"] as? String ?? "",
                        edad: data["edad"] as? String ?? "",
                        sexo: data["sexo"] as? String ?? "",
                        alergias: data["alergias"] as? String ?? "",
                        imagen: nil
                    )
                    print("ID mascota:", doc.documentID)
                    self.mascotas.append(mascota)
                }
                

                DispatchQueue.main.async {
                    self.tableViewMascota.reloadData()
                }
            }
    }
    
    func eliminarMascota(id: String) {
        print("Eliminando ID:", id)
        db.collection("mascotas").document(id).delete { error in
            if let error = error {
                print("❌ Error al eliminar:", error.localizedDescription)
            } else {
                print("🗑 Mascota eliminada")
                self.obtenerMascotas() // recargar lista
            }
        }
    }
    
}

extension MascotaViewController: FormularioMascotaDelegate {
    func agregarMascota(_ mascota: MascotaVM) {
        mascotas.append(mascota)
        DispatchQueue.main.async {
            self.tableViewMascota.reloadData()
        }
    }
}
