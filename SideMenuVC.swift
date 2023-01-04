//
//  SideMenuVC.swift
//  Day12
//
//  Created by Wint Paing on 2023/01/02.
//

import UIKit
enum MenuOptions: String,CaseIterable{
    case home = "Home"
    case setting = "Setting"
    case info = "Information"
    case appRating = "App Rating"
    case sharing = "Share App"
    case version = "Version"
    
    var imageName: String{
        switch self{
        case .home:
            return "house"
        case .setting:
            return "gear"
        case .info:
            return "info.circle"
        case .appRating:
            return "message"
        case .sharing:
            return "phone"
        case .version:
            return "star"
        }
    }
}
protocol SideMenuVCDelegate: AnyObject{
    func didSelectMenu(menu: MenuOptions)
    
}

class SideMenuVC: UIViewController {
    weak var delegate : SideMenuVCDelegate?
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    
}
extension SideMenuVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.didSelectMenu(menu: MenuOptions.allCases[indexPath.row])
    }
    
    
    
}
