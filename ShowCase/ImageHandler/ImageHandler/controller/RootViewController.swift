//
//  ViewController.swift
//  ImageHandler
//
//  Created by Jastin on 18/7/23.
//

import UIKit


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
    
    private lazy var photoTableView: UITableView = {
        let xTableView = UITableView()
        xTableView.translatesAutoresizingMaskIntoConstraints = false
        xTableView.register(UITableViewCell.self, forCellReuseIdentifier: ImageCellKey.key.rawValue)
        xTableView.dataSource = self
        xTableView.allowsSelection = false
        return xTableView
    }()
    
    private var photoList = [Photo]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onCreate()
        self.getPhotoList()
    }
    
    
    
    fileprivate func onCreate() {
        self.setViewStyle()
        self.setControlToSubView()
        self.setImageTableViewConstraint()
    }
    
    fileprivate func getPhotoList() {
        self.dataRepositoryProtocol?.getPhotoList(for: "https://jsonplaceholder.typicode.com/photos", completion: { result in
            switch result {
            case .success(let success):
                self.photoList = success
                DispatchQueue.main.async {
                    self.photoTableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
    fileprivate func setViewStyle() {
        self.view.backgroundColor = .white
    }
    
    fileprivate func setControlToSubView() {
        self.view.addSubview(self.photoTableView)
    }
    
    fileprivate func setImageTableViewConstraint() {
        NSLayoutConstraint.activate([self.photoTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     self.photoTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                                     self.photoTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
                                     self.photoTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
    }
}

extension RootViewController: UITableViewDataSource {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoTableViewCell = tableView.dequeueReusableCell(withIdentifier: ImageCellKey.key.rawValue)!
        let concurrentQueue = DispatchQueue(label: "image.downloader.com", qos: .userInteractive, attributes: .concurrent)
        concurrentQueue.async {
            self.dataRepositoryProtocol?.getPhotoList(for: self.photoList[indexPath.row].url, completion: { dataRepositoryProtocolResult in
                switch dataRepositoryProtocolResult {
                case .success(let success):
                    if let image = UIImage(data: success) {
                       print(indexPath)
                    }
                case .failure(let failure):
                    print(failure)
                } }
            )
        }
        return photoTableViewCell
    }
}

extension RootViewController {
    private enum ImageCellKey: String {
        case key = "cell"
    }
}

