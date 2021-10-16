//
//  CitiesViewController+TableCellAction.swift
//  MyWeather
//
//  Created by mac on 10/16/21.
//

import UIKit

extension CitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
        
        let setDefultAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            
            // Delete the item here
            self?.selectedIndexPath = indexPath
            self?.setDefaultBulletinManager.showBulletin(above: self!)

            completionHandler(true)
        }
        
        setDefultAction.image = UIImage(named: "ic_set_default_cities")
        setDefultAction.backgroundColor = UIColor(named: "DefaultCityColor")

        let configuration = UISwipeActionsConfiguration(actions: [setDefultAction])
        return configuration
        
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            // self?.viewModel.removeCity(indexPath: indexPath)
            self?.selectedIndexPath = indexPath
            self?.deleteBulletinManager.showBulletin(above: self!)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(named: "ic_remove_cities")
        deleteAction.backgroundColor = UIColor(named: "RemoveCityColor")

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
        
    }

}
