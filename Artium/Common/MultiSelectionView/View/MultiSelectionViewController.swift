//
//  MultiSelectionViewController.swift
//  Artium
//
//  Created by Dileep Jaiswal on 17/04/22.
//

import UIKit

protocol MultiSelectionVCDelegate {
    func filterProductsWithSelected(items: [String])
    func sortProductWithSelected(item: String)
}

private let SectionVegetables = 0

class MultiSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var items = [String]()
    var selectedItems = [String]()
    let tableView = UITableView()
    var screenTitle = ""
    var delegate: MultiSelectionVCDelegate?
    var filter = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = screenTitle

        view.addSubview(tableView)
        tableView.allowsMultipleSelectionDuringEditing = true

        //constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        //edit feature
        self.navigationItem.rightBarButtonItem = editButtonItem
        tableView.setEditing(true, animated: true)
        self.navigationItem.rightBarButtonItem!.title = "Done"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = items[indexPath.item].capitalized
        return cell
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItems.append(items[indexPath.row])
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        let value = items[indexPath.row]
        if let index = selectedItems.firstIndex(of: value) {
            selectedItems.remove(at: index)
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            items.remove(at: indexPath.item)
            tableView.reloadData()
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if filter == true {
            delegate?.filterProductsWithSelected(items: selectedItems)
        } else {
            if let last = selectedItems.last {
                delegate?.sortProductWithSelected(item: last)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

