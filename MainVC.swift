//
//  MainVC.swift
//  Day12
//
//  Created by Wint Paing on 2023/01/02.
//

import UIKit
enum MenuState{
    case opened
    case closed
}

class MainVC: UITableViewController {
    
    
    let homeVC = HomeController()
    let menuVC = SideMenuVC()
    lazy var infoVC = InfoVC()
    var navVC: UINavigationController?
    private var menuState = MenuState.closed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVCs()
        view.backgroundColor = .yellow
    }
    
    private func addChildVCs(){
        //Setup menu VC
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        menuVC.delegate = self
        
        //Setup home VC
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        self.navVC = navVC
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        
        
    }
    
}
extension MainVC: HomeControllerDelegate{
    func didTapMenuIcon() {
        toggleMenu(completion: nil)
    }
    func toggleMenu(completion: (() -> Void)?){
        switch menuState{
            
        case .opened:
            //Closed it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            }completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                    
                }
            }
        case .closed:
            //Open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 500
                
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .opened
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}
extension MainVC : SideMenuVCDelegate{
    func didSelectMenu(menu: MenuOptions) {
        print ("did select menu", menu.rawValue)
        toggleMenu(completion: nil)
        switch menu{
            
        case .home:
            addInfoVC(title: menu.rawValue)
        case .setting:
            addInfoVC(title: menu.rawValue)
        case .info:
            addInfoVC(title: menu.rawValue)
        case .appRating:
            addInfoVC(title: menu.rawValue)
        case .sharing:
            addInfoVC(title: menu.rawValue)
        case .version:
            addInfoVC(title: menu.rawValue)
        }
    }
    func addInfoVC(title : String){
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.title = title
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
    }
    func resetToHome(){
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: self)
        homeVC.title = "Home"
    }
}
