//
//  VeterinariosViewController.swift
//  VetCare-v1
//
//  Created by XCODE on 27/04/26.
//

import UIKit

class VeterinariosViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var veterinariosTableView: UITableView!
    
    var veterinariosList: [Veterinarios] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        veterinariosTableView.dataSource = self
        veterinariosList.append(Veterinarios (imagenVet: "veterinario-1", nombreVet: "Pedro Peter Castillo Jara", especialidadVet: "Desparacitacion", disponibilidadVet: "06:00 am - 12:00 pm"))
        veterinariosList.append(Veterinarios (imagenVet: "veterinario-2", nombreVet: "Dina Boluarte Zegarra", especialidadVet: "Baños y Masajes", disponibilidadVet: "12:00 pm - 06:00 pm"))
        veterinariosList.append(Veterinarios (imagenVet: "veterinario-3", nombreVet: "Roberto Sanchez Castillo", especialidadVet: "Sesiones de parto", disponibilidadVet: "06:00 am - 12:00 pm"))
        veterinariosList.append(Veterinarios (imagenVet: "veterinario-4", nombreVet: "Wendy Ramos Alcantara", especialidadVet: "Vacunas y Rayos X", disponibilidadVet: "12:00 pm - 06:00 pm"))
        veterinariosList.append(Veterinarios (imagenVet: "veterinario-5", nombreVet: "Alan Garcia Perez", especialidadVet: "Sesiones de terapia", disponibilidadVet: "06:00 am - 12:00 pm"))
        veterinariosList.append(Veterinarios (imagenVet: "veterinario-6", nombreVet: "Perrozki Elmas Perron", especialidadVet: "Alimentacion", disponibilidadVet: "12:00 pm - 06:00 pm"))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return veterinariosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "veterinariosCell", for: indexPath) as! VeterinariosTableViewCell
        
        let veterinarios = veterinariosList[indexPath.row]
        
        cell.fotovetImageView.image = UIImage(named: veterinarios.imagenVet)
        cell.nombrevetLabel.text = veterinarios.nombreVet
        cell.especialidadvetLabel.text = veterinarios.especialidadVet
        cell.disponibilidadvetLabel.text = veterinarios.disponibilidadVet
        
        return cell
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
