//
//  TablitaViewController.swift
//  Logic
//
//  Created by Noe Osorio on 17/05/18.
//  Copyright © 2018 Noe Osorio. All rights reserved.
//

import UIKit

class TablitaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //Columna
        //Atomo
        return tabla.count + 1 //pow(2, matriz.count)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Fila
        //valor de verdad
        return logica.todo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "columna", for: indexPath) as! CollectionViewCell
        
        if(indexPath.section == 0){
            cell.title.text = tabla[indexPath.section].logica.todo[indexPath.row].data.nombre
            cell.title.textColor = UIColor.black
            
        }
        else{
            cell.title.text = String(tabla[indexPath.section-1].logica.todo[indexPath.row].data.estado)
            if(tabla[indexPath.section-1].logica.todo[indexPath.row].data.estado){
                cell.title.textColor = UIColor.green
            }
            else{
                cell.title.textColor = UIColor.red
            }
        }
        
        
        //cell.title.text = matriz[indexPath.section][indexPath.row]
        //String(indexPath.row)
        
        
        return cell
    }
    

    
    var logica = Logica()
    var tabla: [Tabla] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logica.recorrer()
        tabla = logica.tablita
        
    }

    
    


}
