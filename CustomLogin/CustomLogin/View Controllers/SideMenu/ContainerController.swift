//
//  ContainerContainer.swift
//  SideMenu
//
//  Created by YE002 on 11/04/23.
//

import UIKit
import Firebase
import FirebaseAuth

class ContainerController: UIViewController {
    
    //MARK: - Properties
    
    var menuController: MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    
    //MARK: - init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
        print("configure")
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    //MARK: - Handlers
    
    func configureHomeController() {
        let homeController = HomeController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController(){
        if menuController == nil {
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            
        }
    }
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand {
            //show menu
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: { [self] in
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            },completion: nil)
        } else {
            //hide menu
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut,
                           animations:{
                self.centerController.view.frame.origin.x = 0
            }) { (_)in
                
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        
        animateStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption){
        switch menuOption {
        case .Profile:
            print("Show Profile")
        case .Inbox:
            print("Show Inbox")
        case .Notificationss:
            print("Show notifications")
        case .Signout:
            signout()
            
        }
    }
    
    func signout() {
        do { try Auth.auth().signOut() }
            catch { print("already logged out") }
            navigationController?.popToRootViewController(animated: true)
            print("signout")
    }
    
 
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: { [self] in
            self.setNeedsStatusBarAppearanceUpdate()
        },completion: nil)
    }
}
    extension ContainerController: HomeControllerDelegate {
        func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
            if !isExpanded {
                configureMenuController()
            }
            isExpanded = !isExpanded
            animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
        }
    }
    

