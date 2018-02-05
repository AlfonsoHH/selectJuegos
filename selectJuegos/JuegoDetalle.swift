//
//  ViewController2.swift
//  selectJuegos
//
//  Created by Alfonso Hernandez on 26/1/18.
//  Copyright © 2018 Alfonso Hernandez. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    //variables
    var juego : Juego = Juego()
    @IBOutlet weak var tituloJuego: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var tiempo: UILabel!
    @IBOutlet weak var cooperativo: UILabel!
    @IBOutlet weak var valoracion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //swipe a la derecha
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        
        //
        tituloJuego.text = juego.JuegoMesa
        autor.text = juego.Autor
        //let tiempoMedio : Int? = juego.TiempoMedio
        // tiempoMedioString : String? = String(format:"%f",tiempoMedio)
        tiempo.text = juego.TiempoMedio
        cooperativo.text = juego.Cooperativo
        valoracion.text = juego.Valoracion
    }
}


extension UIViewController
{
    @objc func swipeAction(swipe: UISwipeGestureRecognizer)
    {
       switch  swipe.direction.rawValue{
       case 1:
           performSegue(withIdentifier: "swipeRight", sender: self)
       default:
           break
        }
    }
}


