//
//  HomeControllerViewController.swift
//  Day12
//
//  Created by Wint Paing on 2023/01/02.
//

import UIKit

protocol HomeControllerDelegate: AnyObject{
    func didTapMenuIcon()
}

class HomeController: UIViewController {
    weak var delegate: HomeControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuIcon()
        view.backgroundColor = .blue

        // Do any additional setup after loading the view.
    }
    
    func setUpMenuIcon() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuIcon))
    }
    @objc func didTapMenuIcon(){
        delegate?.didTapMenuIcon()
    }
}
