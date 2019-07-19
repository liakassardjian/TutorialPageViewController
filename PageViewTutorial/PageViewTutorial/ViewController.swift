//
//  ViewController.swift
//  PageViewTutorial
//
//  Created by Lia Kassardjian on 18/07/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Variavel booleana que controla se ja foi feito um acesso anterior ao tutorial
    var acesso: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !acesso { // Se nao tiver sido acessado
            
            // Chama o storyboard "Tutorial"
            let storyboard = UIStoryboard(name: "Tutorial", bundle: nil)
            
            // Instancia, isto e, cria, a ViewController principal colocada no storyboard "Tutorial"
            if let tutorialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? TutorialViewController {
                // Chama a ViewController instanciada
                present(tutorialViewController, animated: true, completion: nil)
                
            }
            
            // Atualiza acesso com true, pois agora o tutorial ja foi acessado
            acesso = true
        }
    }


}

