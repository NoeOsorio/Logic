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
    //var formulas: Array<Formula> = Array()
    //var atomos: [Formula] = []
    var tablaV: [[Bool]] =  []
    //public var todo: [Formula] = []
    var logica: Logica = Logica()
    var palabra: String = ""
    //var head: Formula = Formula(nombre: "")
    var par = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.isEditable = false
        var f1 = Data()
        var f2 = f1
        f1.estado = false
        print(String(f1.estado))
        print(String(f2.estado))
        
        var atomito: Atomo = Atomo()
        atomito.data.append(Formula(nombre: "Prueba"))
        var atomi2 = atomito.copy()
        atomito.data[0].data.estado = false
        print(String(atomito.data[0].data.estado))
        print(String(atomi2.data[0].data.estado))
        
        
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
            destination.logica = logica
            destination.cont = logica.atomos.data.count
        }
        else if let destino = segue.destination as? SecondViewController{
            destino.todo = logica.todo
            destino.palabra = palabra
            destino.head = logica.head
        }
    }
    
    @IBAction func equals(_ sender: Any) {
         palabra = display.text!
        //Limpia
        /*todo.removeAll()
        formulas.removeAll()
        atomos.removeAll()
         */
        logica.clear()
        tablaV.removeAll()
        output.text = ""
        //
        //output.text = palabra
        //logica = Logica(premisa: palabra)
        logica.excecute(premisa: palabra)
        for formula in logica.todo{
            print(formula.data.nombre)
            output.text! += "\n" + formula.data.nombre + " = " + String(formula.data.estado)
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
        logica.clear()
        tablaV.removeAll()
        display.text = ""
        output.text = ""
        par = false
    }
    @IBAction func borrar(_ sender: Any) {
        display.text!.removeLast()
    }
    
    
    
    
}

struct Data {
    var nombre:String = ""
    var estado:Bool = true
    var historial: [Bool] = []
}

class Formula {
    
    var data: Data = Data()
    
    init(nombre: String, estado: Bool){
        self.data.nombre = nombre
        self.data.estado = estado
    }
    
    init(nombre: String){
        self.data.nombre = nombre
        self.data.estado = true
    }
    init(data: Data){
        self.data = data
    }
    func getData() -> Data{
        return self.data
    }
    
    
    
    func makeTrue(){
        data.estado = true
    }
    func makeFalse(){
        data.estado = false
    }
}
class Conjuncion: Formula{
    var izq: Formula
    var der: Formula
    init(izq: Formula, der: Formula){
        var estado: Bool
        self.izq = izq
        self.der = der
        if (izq.data.estado && der.data.estado){
            estado = true
        }
        else{
            estado = false
        }
        super.init(nombre: izq.data.nombre + "^" + der.data.nombre, estado: estado)
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
        if (!izq.data.estado && !der.data.estado){
            estado = false
        }
        else{
            estado = true
        }
        super.init(nombre: izq.data.nombre + "v" + der.data.nombre, estado: estado)
    }
    
}
class Neg: Formula{
    var origen: Formula
    init(formula: Formula) {
        origen = formula
        super.init(nombre: "¬"+formula.data.nombre, estado: !formula.data.estado)
    }
   
}

class Imp: Formula{
    var ant: Formula
    var cons: Formula
    init(ant: Formula, cons: Formula){
        var estado: Bool
        self.ant = ant
        self.cons = cons
        if(ant.data.estado && !cons.data.estado){
            estado = false
        }
        else{
            estado = true
        }
        super.init(nombre: ant.data.nombre + "->" + cons.data.nombre, estado: estado)
    }
  
}
class Equi: Formula{
    var izq: Imp
    var der: Imp
    init(prim: Formula, secu: Formula){
        var estado: Bool
        self.izq = Imp(ant: prim, cons: secu)
        self.der = Imp(ant: secu, cons: prim)
        if (izq.data.estado == der.data.estado){
            estado = true
        }
        else{
            estado = false
        }
        super.init(nombre: prim.data.nombre + "<=>" + secu.data.nombre, estado: estado)
    }
   
}



struct Tabla {
    var logica = Logica()
    init(logic: Logica) {
        self.logica = logic
    }
}
struct Atomo {
    var data: Array<Formula> = Array()
    
    func copy() -> Atomo{
        var tmp = Atomo()
        for formula in self.data{
            let ftmp = formula.getData()
            tmp.data.append(Formula(data: ftmp))
        }
        return tmp
        
    }
}


class Logica {
    var formulas: Array<Formula> = Array()
    //var atomos: Array<Formula> = Array()
    var atomos = Atomo()
    var todo: Array<Formula> = Array()
    var tablita: [Tabla] = []
    var contra: [Tabla] = []
    var head: Formula = Formula(nombre: "")
    
    init(){
        self.unir()
    }
    
    init(premisa: String) {
        head = self.formular(premisa: premisa)
        self.unir()
    }
    init(premisa: String, atomos: [Formula]){
        self.atomos.data = atomos
        head = self.formular(premisa: premisa)
        self.unir()
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
                let i = contains(atomos: atomos.data, element: formu)
                if (i != -1){
                    return atomos.data[i]
                }
                else{
                    atomos.data.append(formu)
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
            let i = contains(atomos: atomos.data, element: formu)
            if (i != -1){
                return atomos.data[i]
            }
            else{
                atomos.data.append(formu)
                return formu
            }
            
        }
        
    }
    func contains(atomos: Array<Formula>, element: Formula) -> Int{
        for (index,atomo) in atomos.enumerated(){
            if(atomo.data.nombre == element.data.nombre){
                return index
            }
        }
        return -1
    }
    
    func excecute(premisa: String){
        head = self.formular(premisa: premisa)
        self.unir()
    }
    func excecute(){
        formulas.removeAll()
        todo.removeAll()
        self.formular(premisa: head.data.nombre)
        self.unir()
    }
    /*func excecute(atm: [Formula]){
        let atomostmp = atomos
        atomos = atm
        formulas.removeAll()
        todo.removeAll()
        self.formular(premisa: head.nombre)
        self.unir()
        atomos = atomostmp
    }*/
    
    func clear(){
        atomos.data.removeAll()
        formulas.removeAll()
        todo.removeAll()
    }
    func unir(){
        for atomo in atomos.data {
            todo.append(atomo)
        }
        for formulita in formulas{
            todo.append(formulita)
        }
    }
    
    func recorrer(){
        
        recorrer(atmp: atomos.copy(), index: 0)
    }
    
    func recorrer(atmp: Atomo ,index: Int) {
        let ato = atmp.copy()
        if(index < 0){
            return
        }
        let i = atomos.data.count - 1
        if(index < i){
            //atomos[index].makeTrue()
            //atomos[index].estado = true
            ato.data[index].data.estado = true
            recorrer(atmp: ato, index: index + 1)
            var ato2 = ato.copy()
            ato2.data[index].data.estado = false
            recorrer(atmp: ato2, index: index + 1)
        }
        else if(index == i){
            ato.data[index].data.estado = true
            //self.excecute()
            let l1 = Tabla(logic: Logica(premisa: self.head.data.nombre, atomos: ato.data))
            let lt = l1
            tablita.append(lt)
            if(!lt.logica.head.data.estado){
                contra.append(lt)
            }
            
            var ato2 = ato.copy()
            ato2.data[index].data.estado = false
            //self.excecute()
            let l2 = Tabla(logic: Logica(premisa: self.head.data.nombre, atomos: ato2.data))
            let lf = l2
            tablita.append(lf)
        }
        return
        
    }
}


