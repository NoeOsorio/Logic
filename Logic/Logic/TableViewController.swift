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
        return atomos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "valores", for: indexPath) as! TableViewCell
        cell.title.text = atomos[indexPath.row].nombre
        cell.estado.isOn = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var celda = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        if(celda.estado.isOn){
            atomos[indexPath.row].estado = true
        }
        else{
            atomos[indexPath.row].estado = false
        }
    }
    var index = IndexPath()
    var formulas: Array<Formula> = Array()
    var atomos: Array<Formula> = Array()
    var premisa = String()
    var cont: Int = 0
    
    
   
    @IBOutlet var TableV: UITableView!
    @IBAction func iniciar(_ sender: Any) {
        
        for (index,atomo) in atomos.enumerated(){
            let indexPath = IndexPath(row: index, section: 0)
            let cell = TableV.cellForRow(at: indexPath) as! TableViewCell
            if(cell.estado.isOn){
                atomo.estado = true
            }
            else{
                atomo.estado = false
            }
        }
        
        performSegue(withIdentifier: "tabla", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ThirdViewController{
            destination.formulas = formulas
            destination.atomos = atomos
            destination.cont = atomos.count
            destination.premisa = premisa
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(formulas.count)
        print(cont)
        
    }
    
}
