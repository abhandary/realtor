//
//  ViewController.swift
//  TestProject
//
//  Created by Sanchay Banerjee on 2021-12-01.
//

import UIKit

/// The purpose of this project is to create an app
/// that downloads data from a specified resource and
/// displays it in a table view.
///
/// Parameters for completion:
/// 1. Complete the implementation for tableView
/// 2. Complete the implementation for activityIndicator
/// 3. Invoke the DataFetcher and render the "Full Name (first-name last-name) separated with a space character in each table view cell"

class ViewController: UIViewController {
  
  var dataFetcher: DataFetcher!
  
  let cellIdentifier = "TableViewCell"
  
  var tableView: UITableView!
  var activityIndicator: UIActivityIndicatorView!
  
  var dataModel: [PersonModel]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "People"
    
    configureDataFetcher()
    configureTableView()
    configureActivityIndicator()
    fetchPeople()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
}

extension ViewController {
  
  private func configureDataFetcher() {
    dataFetcher = DataFetcher(session: URLSession.shared, decoder: CustomDecoder())
  }
  
  private func configureTableView() {
    tableView = UITableView(frame: self.view.frame)
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    self.view.addSubview(tableView)
  }
  
  private func configureActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(style: .large)
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataModel?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
      fatalError("Could not create UI component: \(String(describing: cellIdentifier))")
    }
    cell.textLabel?.text = "\(dataModel[indexPath.row].firstName) \(dataModel[indexPath.row].lastName)"
    return cell
  }
}

extension ViewController {
  private func fetchPeople() {
    self.dataFetcher.fetchPeople { [weak self] result in
      guard let self = self else {
        print("unexpected nil self")
        return
      }
      switch (result) {
      case .failure(let error):
        print(error)
      case .success(let people):
        self.dataModel = people.result
        DispatchQueue.main.async {
          self.tableView.reloadData()
        } 
      }
    }
  }
}
