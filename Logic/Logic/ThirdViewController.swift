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
        return todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "verdad", for: indexPath) as! VerdadTableViewCell
        
        cell.premisa.text = todo[indexPath.row].nombre
        cell.estado.text = String(todo[indexPath.row].estado)
        if(todo[indexPath.row].estado){
            cell.estado.textColor = UIColor.green
        }
        else{
            cell.estado.textColor = UIColor.red
        }
        
        return cell
    }
    

    var todo: Array<Formula> = Array()
    var formulas: Array<Formula> = Array()
    var atomos: Array<Formula> = Array()
    var premisa = String()
    var cont: Int = 0
    
    
    @IBOutlet var display: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formulas.removeAll()
        todo.removeAll()
        formular(premisa: premisa)
        for atomo in atomos {
            todo.append(atomo)
        }
        for formulita in formulas{
            todo.append(formulita)
        }
        for formula in todo{
            print(formula.nombre)
            ///display.text! += "\n" + formula.nombre + " = " + String(formula.estado)
        }
        /*for atomo in atomos{
            display.text! += String(atomo.estado) + "\n"
        }
        */
    }
    
    func formular(premisa: String) -> Formula {
        var word: String.Index
        var izq = ""
        
        if (premisa.contains("(")) {
            if (premisa.first == "(" && premisa.last == ")"){
                var nuevo = String(premisa.dropFirst())
                nuevo = String(nuevo.dropLast())
                let formu = formular(premisa: nuevo)
                //formulas.append(formu)
                return formu
            }
            let inicio = premisa.index(of:"(")!
            let fin = premisa.index(of: ")")!
            izq = String(premisa.prefix(upTo: inicio) + String(premisa.suffix(from: fin)))
            
            //Equivalencia
            if(izq.contains("<")){
                
                (word = premisa.index(of:"<") ?? premisa.endIndex)
                let izq = String(premisa[..<word])
                (word = premisa.index(of:">") ?? premisa.endIndex)
                let der = String(premisa.suffix(from: word).dropFirst())
                //Crea una equivalencia
                let equi = Equi(prim: formular(premisa: izq), secu: formular(premisa: der))
                formulas.append(equi)
                
                return equi
            }
                //Imp
            else if(izq.contains(">")){
                
                (word = premisa.index(of:">") ?? premisa.endIndex)
                let izq = String((premisa[..<word]).dropLast())
                let der = String(premisa.suffix(from: word).dropFirst())
                //Crea una implicacion
                let imp = Imp(ant: formular(premisa: izq), cons: formular(premisa: der))
                formulas.append(imp)
                
                return imp
            }
                
                //Conjuncion
            else if(izq.contains("^")){
                
                (word = premisa.index(of:"^") ?? premisa.endIndex)
                let izq = String(premisa[..<word])
                let der = String(premisa.suffix(from: word).dropFirst())
                //Crea una conjuncion
                let Conj = Conjuncion(izq: formular(premisa: izq), der: formular(premisa: der))
                formulas.append(Conj)
                
                return Conj
            }
                //Disyuncion
            else if(izq.contains("v")){
                (word = premisa.index(of:"v") ?? premisa.endIndex)
                let izq = String(premisa[..<word])
                let der = String(premisa.suffix(from: word).dropFirst())
                //Crea una disyuncion
                let Disy = Disyuncion(izq: formular(premisa: izq), der: formular(premisa: der))
                formulas.append(Disy)
                //todo.append(Disy)
                return Disy
            }
                //Negacion
            else if(izq.contains("¬")){
                (word = premisa.index(of:"¬") ?? premisa.endIndex)
                //Formula original
                let original = String(premisa.dropFirst())
                let antiformula = Neg(formula: formular(premisa: original))
                formulas.append(antiformula)
                //todo.append(antiformula)
                
                return antiformula
                
            }
                
            else{
                let formu = Formula(nombre: premisa)
                let i = contains(atomos: atomos, element: formu)
                if (i != -1){
                    return atomos[i]
                }
                else{
                    atomos.append(formu)
                    return formu
                }
            }
        }
            //Equivalencia
        else if(premisa.contains("<")){
            
            (word = premisa.index(of:"<") ?? premisa.endIndex)
            let izq = String(premisa[..<word])
            (word = premisa.index(of:">") ?? premisa.endIndex)
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una equivalencia
            let equi = Equi(prim: formular(premisa: izq), secu: formular(premisa: der))
            formulas.append(equi)
            
            return equi
        }
            //Imp
        else if(premisa.contains(">")){
            
            (word = premisa.index(of:">") ?? premisa.endIndex)
            let izq = String((premisa[..<word]).dropLast())
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una implicacion
            let imp = Imp(ant: formular(premisa: izq), cons: formular(premisa: der))
            formulas.append(imp)
            
            return imp
        }
            //Conjuncion
        else if(premisa.contains("^")){
            
            (word = premisa.index(of:"^") ?? premisa.endIndex)
            let izq = String(premisa[..<word])
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una conjuncion
            let Conj = Conjuncion(izq: formular(premisa: izq), der: formular(premisa: der))
            formulas.append(Conj)
            
            return Conj
        }
            //Disyuncion
        else if(premisa.contains("v")){
            (word = premisa.index(of:"v") ?? premisa.endIndex)
            let izq = String(premisa[..<word])
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una disyuncion
            let Disy = Disyuncion(izq: formular(premisa: izq), der: formular(premisa: der))
            formulas.append(Disy)
            //todo.append(Disy)
            return Disy
        }
            //Negacion
        else if(premisa.contains("¬")){
            (word = premisa.index(of:"¬") ?? premisa.endIndex)
            //Formula original
            let original = String(premisa.dropFirst())
            let antiformula = Neg(formula: formular(premisa: original))
            formulas.append(antiformula)
            //todo.append(antiformula)
            
            return antiformula
            
        }
            
        else{
            let formu = Formula(nombre: premisa)
            //todo.append(formu)
            let i = contains(atomos: atomos, element: formu)
            if (i != -1){
                return atomos[i]
            }
            else{
                atomos.append(formu)
                return formu
            }
            
        }
        
    }
    func contains(atomos: Array<Formula>, element: Formula) -> Int{
        for (index,atomo) in atomos.enumerated(){
            if(atomo.nombre == element.nombre){
                return index
            }
        }
        return -1
    }


}
