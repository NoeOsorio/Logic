//
//  SecondViewController.swift
//  Logic
//
//  Created by Noe Osorio on 13/05/18.
//  Copyright © 2018 Noe Osorio. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logica.todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "contra", for: indexPath) as! VerdadTableViewCell
        
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
    
    var logica = Logica()
    var palabra = ""
    var cont: Int = 0
    
    @IBOutlet var Tauto: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let contradiccion = makeFalse(premisa: head)
        
        //print(palabra)
        //print(formulas.count)
        //print(cont)
        
        if(logica.esContra()){
            Tauto.text = "No Tautologia"
        }
        else{
            Tauto.text = "Tautologia"
        }
        
    }
    
    
    

   

}

