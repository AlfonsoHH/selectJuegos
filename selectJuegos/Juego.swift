//
//  Juego.swift
//  selectJuegos
//
//  Created by Alfonso Hernandez on 19/1/18.
//  Copyright © 2018 Alfonso Hernandez. All rights reserved.
//

import Foundation

class Juego: NSObject {
    
    //variable del POJO
    
    var JuegoMesa: String?
    var Autor: String?
    var TiempoMedio: Int?
    var Cooperativo: Int?
    var Valoracion: Double?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    init(JuegoMesa: String, Autor: String, TiempoMedio: Int, Cooperativo: Int, Valoracion: Double) {
        self.JuegoMesa = JuegoMesa
        self.Autor = Autor
        self.TiempoMedio = TiempoMedio
        self.Cooperativo = Cooperativo
        self.Valoracion = Valoracion
        
    }
    
    
    //prints object's current state
    /*
    override var description: String {
        return "cod: \(JuegoMesa), cosa: \(cosa)"
        
    }
    */
    
}
