//
//  PageViewController.swift
//  PageViewTutorial
//
//  Created by Lia Kassardjian on 18/07/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    // Vetor que contem as ViewControllers da PageViewController ordenadas
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController: "sbRed"),
                self.newVC(viewController: "sbBlue"),
                self.newVC(viewController: "sbGreen"),
                self.newVC(viewController: "sbPurple")]
    }()
    
    // Representa o indice da pagina que esta sendo exibida no momento
    var currentIndex = 0
    
    // Remete a ViewController principal colocada no Storyboard
    var mainViewController: TutorialViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            // Configura a ViewController que deve ser apresentada primeiro
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        self.delegate = self
    }

    // Funcao que instancia, isto e, cria uma ViewController cujo identificador e viewController: String
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Tutorial", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    // Configura paginas anteriores
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Busca o indice da pagina que esta sendo analisada
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        // Proximo indice
        let previousIndex = viewControllerIndex - 1
        
        return self.contentViewControler(at: previousIndex)
    }
    
    // Configura paginas posteriores
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // Busca o indice da pagina que esta sendo analisada
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        // Proximo indice
        let nextIndex = viewControllerIndex + 1
        
        return self.contentViewControler(at: nextIndex)
    }
    
    // Funcao que verifica se o indice eh valido. Caso sim, retorna a ViewController correspondente ao indice; caso não, retorna nil
    func contentViewControler(at index: Int) -> UIViewController? {
        if index < 0 || index >= orderedViewControllers.count {
            return nil
        }
        
        return orderedViewControllers[index]
    }
    
    // Funcao chamada quando a transicao de uma pagina para a outra eh concluida
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // ViewController atual
        let pageContentViewController = pageViewController.viewControllers![0]
        
        // Atualiza o indice atual com o indice da nova pagina
        self.currentIndex = orderedViewControllers.firstIndex(of: pageContentViewController)!
        
        if let mVC = mainViewController {
            mVC.updateUI() // Chama o metodo de mainViewController que atualiza a interface
        }
    }
    
    // Funcao que avanca uma pagina
    func forwardPage() {
        currentIndex += 1 // incremente o indice atual
        
        // Avanca uma pagina
        if let nextViewController = self.contentViewControler(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    

}
