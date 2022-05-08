//
//  MessagesViewController.swift
//  Messages
//
//  Created by Denis on 06.05.2022.
//

import UIKit

class MessagesViewController: UIViewController {
    
    private let tableView = UITableView()
    private let activityIndicatorCenter = UIActivityIndicatorView()
    private let activityIndicatorTop = UIActivityIndicatorView()
    
    private var messages = [String]()
    private var isFetching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = DynamicColor(light: .white, dark: .black).resolve()
        addSubviews()
        configureSubviews()
        makeConstraints()
        showLoaderCenter()
        fetchData()
    }
    
    private func addSubviews() {
        [activityIndicatorCenter, activityIndicatorTop, tableView].forEach(view.addSubview(_:))
    }
    
    private func configureSubviews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        navigationItem.title = "Сообщения"
    }
    
    private func makeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorCenter.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorTop.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorTop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorTop.topAnchor.constraint(equalTo: tableView.topAnchor),
            
            activityIndicatorCenter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorCenter.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func fetchData() {
        guard !isFetching else { return }
        isFetching = true
        FetchManager.shared.fetchData() { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.hideLoaderCenter()
                switch result {
                case let .success(fetchMessages):
                    self?.tableView.isHidden = false
                    self?.messages = fetchMessages
                    self?.tableView.reloadData()
                case let .failure(error):
                    self?.tableView.isHidden = true
                    self?.showAlert(error: error)
                }
                self?.isFetching = false
            }
        }
    }
    
    func showAlert(error: FetchError) {
        let alertController = UIAlertController(title: "Ошибка", message: error.message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Повторить", style: .default) { [weak self] _ in
            self?.showLoaderCenter()
            self?.fetchData()
        }
        
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .justified
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MessagesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0, scrollView.isDragging {
            showLoaderTop()
            fetchData()
        } else {
            hideLoaderTop()
        }
    }
}

private extension MessagesViewController {
    
    func showLoaderTop() {
        activityIndicatorTop.isHidden = false
        activityIndicatorTop.startAnimating()
    }
    
    func hideLoaderTop() {
        activityIndicatorTop.isHidden = true
        activityIndicatorTop.stopAnimating()
    }
    
    func showLoaderCenter() {
        activityIndicatorCenter.isHidden = false
        activityIndicatorCenter.startAnimating()
    }
    
    func hideLoaderCenter() {
        activityIndicatorCenter.isHidden = true
        activityIndicatorCenter.stopAnimating()
    }
}

