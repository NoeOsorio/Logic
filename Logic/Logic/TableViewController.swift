//
//  TableViewController.swift
//  Logic
//
//  Created by Noe Osorio on 15/05/18.
//  Copyright © 2018 Noe Osorio. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logica.atomos.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "valores", for: indexPath) as! TableViewCell
        cell.title.text = logica.atomos.data[indexPath.row].data.nombre
        cell.estado.isOn = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var celda = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        if(celda.estado.isOn){
            logica.atomos.data[indexPath.row].data.estado = true
        }
        else{
            logica.atomos.data[indexPath.row].data.estado = false
        }
    }
    var index = IndexPath()
    var logica: Logica = Logica()
    //var premisa = String()
    var cont: Int = 0
    
    
   
    @IBOutlet var TableV: UITableView!
    @IBAction func iniciar(_ sender: Any) {
        
        for (index,atomo) in logica.atomos.data.enumerated(){
            let indexPath = IndexPath(row: index, section: 0)
            let cell = TableV.cellForRow(at: indexPath) as! TableViewCell
            
            if(cell.estado.isOn){
                atomo.data.estado = true
            }
            else{
                atomo.data.estado = false
            }
        }
        
        performSegue(withIdentifier: "formalizar", sender: self)
    }
    
    
    @IBAction func Tabla(_ sender: Any) {
        performSegue(withIdentifier: "tabla", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThirdViewController{
            destination.logica = logica
            destination.cont = logica.atomos.data.count
            destination.premisa = logica.head.data.nombre
        }
        else if let destino = segue.destination as? TablitaViewController{
            destino.logica = Logica(premisa: logica.head.data.nombre)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(logica.formulas.count)
        print(cont)
        
    }
    
}
