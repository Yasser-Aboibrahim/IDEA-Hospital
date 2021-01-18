//
//  TabBarVC.swift
//  IDEA_Hospital_Team4
//
//  Created by Hossam on 12/13/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

        //MARK:- Properties
        let searchServicesNav = UINavigationController()
        let favoriteNav = UINavigationController()
        let appointmentNav = UINavigationController()
        
        //MARK:- Life Cycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        //MARK:- Public Methods
        class func create(categoryID: Int) -> TabBarVC {
            let tabBarVC = TabBarVC()
            let searchServicesVC = tabBarVC.createServiceSearchVC(with: categoryID)
            let favVC = tabBarVC.createFavoriteVC()
            let appointmentVC = tabBarVC.createAppointmentsVC()
            tabBarVC.viewControllers = [searchServicesVC, favVC, appointmentVC]
            return tabBarVC
        }
        
        override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            switch item.tag {
            case 1:
                title = "Services Search"
            case 2:
                title = "MY FAVORITES"
            default:
                title = "MY APPOINTMETS"
            }
        }
    }
    
    //MARK:- Private Methods
    extension TabBarVC {
        
        private func createServiceSearchVC(with categoryID: Int) -> UINavigationController {
            let serviceSearchVC = SearchServicesVC.create(categoryID: categoryID)
            serviceSearchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "Search"), tag: 1)
            searchServicesNav.viewControllers = [serviceSearchVC]
            return searchServicesNav
        }
        
        private func createFavoriteVC() -> UINavigationController {
            let favoriteVC = MyFavoritesVC.create(comeFromSettings: false)
            favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favourite"), tag: 2)
            favoriteNav.viewControllers = [favoriteVC]
            return favoriteNav
        }
        
        private func createAppointmentsVC() -> UINavigationController {
            let appointmentsVC = MyAppointmentsVC.create(comeFromSettings: false)
            appointmentsVC.tabBarItem = UITabBarItem(title: "Scedule", image: UIImage(named: "Calendar") , tag: 3)
            appointmentNav.viewControllers = [appointmentsVC]
            return appointmentNav
        }
        
        private func goToSettingsVC() {
            let settingsVC = SettingsVC.create()
            navigationController?.pushViewController(settingsVC, animated: true)
        }
        
        private func gotoHomeScreen(){
            navigationController?.popViewController(animated: true)
        }
}


