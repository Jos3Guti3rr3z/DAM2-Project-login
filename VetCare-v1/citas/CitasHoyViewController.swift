//
//  CitasHoyViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 29/04/26.
//

import UIKit

class CitasHoyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // Nuestro "almacén" de citas
    var listaCitas: [Cita] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // IMPORTANTE: Conectar la tabla al código
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Configuración de la Tabla (DataSource)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCitas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. Llamamos a la celda personalizada usando el nombre de su clase
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CitaTableViewCell
        
        let cita = listaCitas[indexPath.row]
        
        // 2. Asignamos los datos a cada Label que dibujaste
        cell.lblNombreMascota.text = cita.nombreMascota
        cell.lblNombreDueño.text = cita.nombreDueño
        cell.lblFecha.text = cita.fecha
        cell.lblHora.text = cita.hora
        cell.lblMotivo.text = cita.motivo
        
        return cell
    }

    // MARK: - Navegación
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Si el identificador del Segue es "irANuevaCita"
        if segue.identifier == "irANuevaCita" {
            if let destinoVC = segue.destination as? NuevaCitaViewController {
                destinoVC.delegate = self
            }
        }
    }
}

// MARK: - Recibir la Cita (Protocolo)
extension CitasHoyViewController: NuevaCitaDelegate {
    func agregarNuevaCita(_ cita: Cita) {
        self.listaCitas.append(cita) // Guardamos en el array
        self.tableView.reloadData()  // Refrescamos la tabla visualmente
    }
}
