//
//  MainViewController.swift
//  PageViewTutorial
//
//  Created by Lia Kassardjian on 19/07/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 25
            self.nextButton.layer.masksToBounds = true
        }
    }
    
    // Remete ao PageViewController colocado no Storyboard
    var pageViewController: PageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Quando o botão "pular" é pressionado, volta para a tela pricipal do aplicativo
    @IBAction func skipButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Quando o botão "proximo" é pressionado, avanca uma pagina
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let index = pageViewController?.currentIndex { // recupera o indice da pagina atual
            switch index {
            case 0...2: // qualquer pagina exceto a ultima
                pageViewController?.forwardPage() // avanca uma página
                
            case 3: // ultima pagina
                dismiss(animated: true, completion: nil)
                
            default:
                break
            }
        }
        updateUI() // atualiza a interface
    }
    
    func updateUI() {
        if let index = pageViewController?.currentIndex { // recupera o indice da pagina atual
            switch index {
            case 0...2: // qualquer pagina exceto a ultima
                nextButton.setTitle("Próximo", for: .normal) // configura titulo do nextButton
                skipButton.isHidden = false // botao "pular" nao fica escondido
                
            case 3:
                nextButton.setTitle("Começar", for: .normal) // configura titulo do nextButton
                skipButton.isHidden = true // botao "pular" fica escondido
                
            default:
                break
            }
            pageControl.currentPage = index // atualiza a bolinha do page control
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pVC = destination as? PageViewController {
            pageViewController = pVC // configura a variavel pageViewController com a PageViewController colocada no storyboard
            pVC.mainViewController = self // avisa para pVC que a variavel mainViewController corresponde a ViewController principal que foi colocada no storyboar, isto e, ela mesma
        }
    }

}
