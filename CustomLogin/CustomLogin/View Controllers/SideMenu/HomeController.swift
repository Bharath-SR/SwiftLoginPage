//  HomeController.swift
//  SideMenu
//
//  Created by YE002 on 11/04/23.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    var delegate: HomeControllerDelegate?
    
    //MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
        
    }
    
    //MARK: - Handlers

    
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Notes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        guard let notesViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Storyboard.notesViewController) as? ViewController
        else { return }
        self.view.addSubview(notesViewController.view)
        self.addChild(notesViewController)
        self.didMove(toParent: self)
    }
}
