//
//  ThirdViewController.swift
//  Logic
//
//  Created by Noe Osorio on 16/05/18.
//  Copyright © 2018 Noe Osorio. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logica.todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verdad", for: indexPath) as! VerdadTableViewCell
        
        cell.premisa.text = logica.todo[indexPath.row].data.nombre
        cell.estado.text = String(logica.todo[indexPath.row].data.estado)
        if(logica.todo[indexPath.row].data.estado){
            cell.estado.textColor = UIColor.green
        }
        else{
            cell.estado.textColor = UIColor.red
        }
        
        return cell
    }
    

    var logica: Logica = Logica()
    var premisa = String()
    var cont: Int = 0
    
    
    @IBOutlet var display: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logica.formulas.removeAll()
        logica.todo.removeAll()
        //Ejecuta las funciones para sacar todas las formulas y los atomos
        logica.excecute(premisa: premisa)
        for formula in logica.todo{
            print(formula.data.nombre)
            ///display.text! += "\n" + formula.nombre + " = " + String(formula.estado)
        }
        
    }
    
    


}
