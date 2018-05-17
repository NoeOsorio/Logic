//
//  FirstViewController.swift
//  Logic
//
//  Created by Noe Osorio on 13/05/18.
//  Copyright © 2018 Noe Osorio. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

   
    @IBOutlet var borrar: UIButton!
    @IBOutlet var clear: UIButton!
    @IBOutlet var output: UITextView!
    @IBOutlet var display: UITextField!
    var formulas: Array<Formula> = Array()
    var atomos: [Formula] = []
    var tablaV: [[Bool]] =  []
    public var todo: [Formula] = []
    var palabra: String = ""
    var head: Formula = Formula(nombre: "")
    var par = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.isEditable = false
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Letras
    @IBAction func A(_ sender: Any) {
        display.text!.append("A")
    }
    @IBAction func B(_ sender: Any) {
        display.text!.append("B")
    }
    @IBAction func C(_ sender: Any) {
        display.text!.append("C")
    }
    @IBAction func D(_ sender: Any) {
        display.text!.append("D")
    }
    @IBAction func E(_ sender: Any) {
        display.text!.append("E")
    }
    @IBAction func F(_ sender: Any) {
        display.text!.append("F")
    }
    @IBAction func P(_ sender: Any) {
        display.text!.append("P")
    }
    @IBAction func Q(_ sender: Any) {
        display.text!.append("Q")
    }
    @IBAction func R(_ sender: Any) {
        display.text!.append("R")
    }
    
    //Funciones
    
    @IBAction func contra(_ sender: Any) {
        performSegue(withIdentifier: "contra", sender: self)
    }
    @IBAction func tabla(_ sender: Any) {
        //performSegue(withIdentifier: "nexo", sender: self)
        performSegue(withIdentifier: "valor", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? TableViewController{
            destination.formulas = formulas
            destination.atomos = atomos
            destination.cont = atomos.count
            destination.premisa = palabra
        }
        else if let destino = segue.destination as? SecondViewController{
            destino.todo = todo
            destino.palabra = palabra
            destino.head = head
        }
    }
    
    @IBAction func equals(_ sender: Any) {
         palabra = display.text!
        //Limpia
        todo.removeAll()
        formulas.removeAll()
        atomos.removeAll()
        tablaV.removeAll()
        output.text = ""
        //
        //output.text = palabra
        head = formular(premisa: palabra)
        for atomo in atomos {
            todo.append(atomo)
        }
        for formulita in formulas{
            todo.append(formulita)
        }
        
        for formula in todo{
            print(formula.nombre)
            output.text! += "\n" + formula.nombre + " = " + String(formula.estado)
        }
        
        
    }
    @IBAction func and(_ sender: Any) {
        display.text!.append("^")
    }
    @IBAction func or(_ sender: Any) {
        display.text!.append("v")
    }
    @IBAction func imp(_ sender: Any) {
        display.text!.append("->")
    }
    @IBAction func neg(_ sender: Any) {
        display.text!.append("¬")
    }
    @IBAction func par(_ sender: Any) {
        if (par){
            par = false
            display.text!.append(")")
        }
        else{
            par = true
            display.text!.append("(")
        }
    }
    @IBAction func equi(_ sender: Any) {
        display.text!.append("<=>")
    }
    @IBAction func clear(_ sender: Any) {
        todo.removeAll()
        formulas.removeAll()
        atomos.removeAll()
        tablaV.removeAll()
        display.text = ""
        output.text = ""
        par = false
    }
    @IBAction func borrar(_ sender: Any) {
        display.text!.removeLast()
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

class Formula {
    var nombre:String
    var estado:Bool
    
    init(nombre: String, estado: Bool){
        self.nombre = nombre
        self.estado = estado
    }
    
    init(nombre: String){
        self.nombre = nombre
        self.estado = true
    }
    func makeTrue() -> Formula{
        estado = true
        return self
    }
    func makeFalse() -> Formula{
        estado = false
        return self
    }
}
class Conjuncion: Formula{
    var izq: Formula
    var der: Formula
    init(izq: Formula, der: Formula){
        var estado: Bool
        self.izq = izq
        self.der = der
        if (izq.estado && der.estado){
            estado = true
        }
        else{
            estado = false
        }
        super.init(nombre: izq.nombre + "^" + der.nombre, estado: estado)
    }
    override func makeTrue() -> Formula{
        izq.estado = true
        der.estado = true
        return self
        
    }
    override func makeFalse() -> Formula{
        if(estado){
            
        }
        if(izq.estado && !der.estado){
            izq.makeTrue()
            der.makeFalse()
        }
        else if (!izq.estado && der.estado){
            izq.makeFalse()
            der.makeTrue()
        }
        else if (!izq.estado && !der.estado){
            izq.makeFalse()
            der.makeFalse()
        }
        
        return self
        
    }
}
class Disyuncion: Formula{
    var izq: Formula
    var der: Formula
    //Arreglo de Formulas
    init(izq: Formula, der: Formula){
        var estado: Bool
        self.izq = izq
        self.der = der
        if (!izq.estado && !der.estado){
            estado = false
        }
        else{
            estado = true
        }
        super.init(nombre: izq.nombre + "v" + der.nombre, estado: estado)
    }
    override func makeTrue() -> Formula{
        if(izq.estado && !der.estado){
            izq.makeTrue()
            der.makeFalse()
        }
        else if (!izq.estado && der.estado){
            izq.makeFalse()
            der.makeTrue()
        }
        else{
            izq.makeTrue()
            der.makeTrue()
        }
        
        return self
        
    }
    override func makeFalse() -> Formula{
        izq.makeFalse()
        der.makeFalse()
        return self
        
    }
}
class Neg: Formula{
    var origen: Formula
    init(formula: Formula) {
        origen = formula
        super.init(nombre: "¬"+formula.nombre, estado: !formula.estado)
    }
    override func makeTrue() -> Formula {
        origen.makeFalse()
        return self
    }
    override func makeFalse() -> Formula {
        origen.makeTrue()
        return self
    }
}

class Imp: Formula{
    var ant: Formula
    var cons: Formula
    init(ant: Formula, cons: Formula){
        var estado: Bool
        self.ant = ant
        self.cons = cons
        if(ant.estado && !cons.estado){
            estado = false
        }
        else{
            estado = true
        }
        super.init(nombre: ant.nombre + "->" + cons.nombre, estado: estado)
    }
    override func makeFalse() -> Formula {
        ant.makeTrue()
        cons.makeFalse()
        return self
    }
    override func makeTrue() -> Formula {
        if(!ant.estado && cons.estado){
            ant.makeFalse()
            cons.makeTrue()
        }
        else if (!ant.estado && !cons.estado){
            ant.makeFalse()
            cons.makeFalse()
        }
        else{
            ant.makeTrue()
            cons.makeTrue()
        }
        return self
    }
}
class Equi: Formula{
    var izq: Imp
    var der: Imp
    init(prim: Formula, secu: Formula){
        var estado: Bool
        self.izq = Imp(ant: prim, cons: secu)
        self.der = Imp(ant: secu, cons: prim)
        if (izq.estado == der.estado){
            estado = true
        }
        else{
            estado = false
        }
        super.init(nombre: prim.nombre + "<=>" + secu.nombre, estado: estado)
    }
    override func makeTrue() -> Formula {
        if(izq.estado && der.estado){
            izq.makeTrue()
            der.makeTrue()
        }
        else{
            izq.makeFalse()
            der.makeFalse()
        }
        return self
    }
    override func makeFalse() -> Formula {
        if(!izq.estado && der.estado){
            izq.makeFalse()
            der.makeTrue()
        }
        else if (izq.estado && !der.estado){
            izq.makeTrue()
            der.makeFalse()
        }
        return self
    }
}


