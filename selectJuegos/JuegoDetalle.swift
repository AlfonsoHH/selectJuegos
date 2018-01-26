//
//  ViewController2.swift
//  selectJuegos
//
//  Created by Alfonso Hernandez on 26/1/18.
//  Copyright © 2018 Alfonso Hernandez. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension UIViewController
{
    @objc func swipeAction(swipe: UISwipeGestureRecognizer)
    {
       switch  swipe.direction.rawValue{
       case 1:
           performSegue(withIdentifier: "swipeBack", sender: self)
       default:
           break
        }
    }
}


