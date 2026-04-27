//
//  MascotaViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 22/04/26.
//

import UIKit

class MascotaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    

    var mascotas: [MascotaVM] = []
    

    @IBOutlet weak var tableViewMascota: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tableViewMascota:", tableViewMascota as Any)
        tableViewMascota.dataSource = self
        tableViewMascota.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("🚀 SE EJECUTÓ SEGUE:", segue.identifier ?? "sin id")
            
            if segue.identifier == "irFormulario" {
                let destino = segue.destination as! FormularioMascotaViewController
                destino.delegate = self
                print("✅ DELEGATE ASIGNADO")
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
