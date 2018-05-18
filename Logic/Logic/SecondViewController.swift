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
        return todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "contra", for: indexPath) as! VerdadTableViewCell
        
        cell.premisa.text = todo[indexPath.row].data.nombre
        cell.estado.text = String(todo[indexPath.row].data.estado)
        if(todo[indexPath.row].data.estado){
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
    var head = Formula(nombre: "")
    var palabra = ""
    var cont: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let contradiccion = makeFalse(premisa: head)
        
        print(palabra)
        print(formulas.count)
        print(cont)
        
    }
    
    func makeFalse(premisa: String) -> Formula{
        var word: String.Index
        var izq = ""
        
        if (premisa.contains("(")) {
            //Parentesis
            if (premisa.first == "(" && premisa.last == ")"){
                var nuevo = String(premisa.dropFirst())
                nuevo = String(nuevo.dropLast())
                let formu = makeFalse(premisa: nuevo)
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
                let equi = Equi(prim: makeFalse(premisa: izq), secu: makeFalse(premisa: der))
                formulas.append(equi)
                
                return equi
            }
                //Imp
            else if(izq.contains(">")){
                
                (word = premisa.index(of:">") ?? premisa.endIndex)
                let izq = String((premisa[..<word]).dropLast())
                let der = String(premisa.suffix(from: word).dropFirst())
                //Crea una implicacion
                let imp = Imp(ant: makeFalse(premisa: izq), cons: makeFalse(premisa: der))
                formulas.append(imp)
                
                return imp
            }
                
                //Conjuncion
            else if(izq.contains("^")){
                
                (word = premisa.index(of:"^") ?? premisa.endIndex)
                let izq = String(premisa[..<word])
                let der = String(premisa.suffix(from: word).dropFirst())
                //Crea una conjuncion
                let Conj = Conjuncion(izq: makeFalse(premisa: izq), der: makeFalse(premisa: der))
                formulas.append(Conj)
                
                return Conj
            }
                //Disyuncion
            else if(izq.contains("v")){
                (word = premisa.index(of:"v") ?? premisa.endIndex)
                let izq = String(premisa[..<word])
                let der = String(premisa.suffix(from: word).dropFirst())
                //Crea una disyuncion
                let Disy = Disyuncion(izq: makeFalse(premisa: izq), der: makeFalse(premisa: der))
                formulas.append(Disy)
                //todo.append(Disy)
                return Disy
            }
                //Negacion
            else if(izq.contains("¬")){
                (word = premisa.index(of:"¬") ?? premisa.endIndex)
                //Formula original
                let original = String(premisa.dropFirst())
                let antiformula = Neg(formula: makeFalse(premisa: original))
                formulas.append(antiformula)
                //todo.append(antiformula)
                
                return antiformula
                
            }
                
            else{
                let formu = Formula(nombre: premisa)
                
                    atomos.append(formu)
                    return formu
                
            }
        }
            //Equivalencia
        else if(premisa.contains("<")){
            
            (word = premisa.index(of:"<") ?? premisa.endIndex)
            let izq = String(premisa[..<word])
            (word = premisa.index(of:">") ?? premisa.endIndex)
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una equivalencia
            let equi = Equi(prim: makeFalse(premisa: izq), secu: makeFalse(premisa: der))
            formulas.append(equi)
            
            return equi
        }
            //Imp
        else if(premisa.contains(">")){
            
            (word = premisa.index(of:">") ?? premisa.endIndex)
            let izq = String((premisa[..<word]).dropLast())
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una implicacion
            let imp = Imp(ant: makeFalse(premisa: izq), cons: makeFalse(premisa: der))
            formulas.append(imp)
            
            return imp
        }
            //Conjuncion
        else if(premisa.contains("^")){
            
            (word = premisa.index(of:"^") ?? premisa.endIndex)
            let izq = String(premisa[..<word])
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una conjuncion
            let Conj = Conjuncion(izq: makeFalse(premisa: izq), der: makeFalse(premisa: der))
            formulas.append(Conj)
            
            return Conj
        }
            //Disyuncion
        else if(premisa.contains("v")){
            (word = premisa.index(of:"v") ?? premisa.endIndex)
            let izq = String(premisa[..<word])
            let der = String(premisa.suffix(from: word).dropFirst())
            //Crea una disyuncion
            let Disy = Disyuncion(izq: makeFalse(premisa: izq), der: makeFalse(premisa: der))
            formulas.append(Disy)
            //todo.append(Disy)
            return Disy
        }
            //Negacion
        else if(premisa.contains("¬")){
            (word = premisa.index(of:"¬") ?? premisa.endIndex)
            //Formula original
            let original = String(premisa.dropFirst())
            let antiformula = Neg(formula: makeFalse(premisa: original))
            formulas.append(antiformula)
            //todo.append(antiformula)
            
            return antiformula
            
        }
            
        else{
            let formu = Formula(nombre: premisa)
            //todo.append(formu)
            
                atomos.append(formu)
                return formu
            }
            
    }
    

   

}

