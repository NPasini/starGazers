//
//  CellFactory.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

import UIKit

enum CellFactory {
    static func makeCell(in tableView: UITableView, forRowAt indexPath: IndexPath, model: StarGazer) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StarGazerTableViewCell.identifier, for: indexPath) as? StarGazerTableViewCell {
            cell.configure(with: model)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
