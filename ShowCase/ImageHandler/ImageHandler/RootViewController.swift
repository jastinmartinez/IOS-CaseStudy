//
//  ViewController.swift
//  ImageHandler
//
//  Created by Jastin on 18/7/23.
//

import UIKit


protocol DataSourceProtocol: AnyObject {
    func getData(completion: @escaping (Result<Data, Error>) -> Void)
}

final class DataSource: DataSourceProtocol {

    private let path = "https://jsonplaceholder.typicode.com/photos"
    
    func getData(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: self.path) else {
            fatalError("failed to create URL for \(path)")
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid HTTP Response", code: 0)))
                return
            }
            guard response.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid Status Code", code: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Nil Data", code: 3)))
                return
            }
            completion(.success(data))
        }).resume()
    }
}

protocol DataRepositoryProtocol: AnyObject {
    func getPhotoList(completion: (Result<[String], Error>) -> Void)
    func getPhotoList(for photoURL: String, completion: (Result<Data, Error>) -> Void)
}

final class DataRepository: DataRepositoryProtocol {
    
    func getPhotoList(completion: (Result<[String], Error>) -> Void) {
        
    }
    
    func getPhotoList(for photoURL: String, completion: (Result<Data, Error>) -> Void) {
        
    }
}

class RootViewController: UIViewController {
    
    private let dataRepositoryProtocol: DataRepositoryProtocol?
    
    init(dataRepositoryProtocol: DataRepositoryProtocol) {
        self.dataRepositoryProtocol = dataRepositoryProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.dataRepositoryProtocol = nil
        super.init(coder: coder)
    }
    
    private lazy var imageTableView: UITableView = {
        let xTableView = UITableView()
        xTableView.translatesAutoresizingMaskIntoConstraints = false
        xTableView.register(UITableViewCell.self, forCellReuseIdentifier: ImageCellKey.key.rawValue)
        xTableView.dataSource = self
        return xTableView
    }()
    
    private var imageDataList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
    }
    
    fileprivate func onCreate() {
        self.setViewStyle()
        self.setControlToSubView()
        self.setImageTableViewConstraint()
    }
    
    fileprivate func setViewStyle() {
        self.view.backgroundColor = .white
    }
    
    fileprivate func setControlToSubView() {
        self.view.addSubview(self.imageTableView)
    }
    
    fileprivate func setImageTableViewConstraint() {
        NSLayoutConstraint.activate([self.imageTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.imageTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                     self.imageTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                     self.imageTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imageDataList.count
    }
    
    fileprivate func cellDataConfigurationFor(_ imageTableViewCell: UITableViewCell, on indexPath: IndexPath) {
        let contentConfiguration = UIListContentConfiguration.cell()
        imageTableViewCell.contentConfiguration = contentConfiguration
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageTableViewCell = tableView.dequeueReusableCell(withIdentifier: ImageCellKey.key.rawValue)!
        self.cellDataConfigurationFor(imageTableViewCell, on: indexPath)
        return imageTableViewCell
    }
}

extension RootViewController {
    private enum ImageCellKey: String {
        case key = "cell"
    }
}
