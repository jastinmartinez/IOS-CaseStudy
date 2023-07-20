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
        xTableView.prefetchDataSource = self
        return xTableView
    }()
    
    private var photoList = [Photo]()
    private var operations = [IndexPath: ImageOperation]()
    private var operationQueue = OperationQueue()
    
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

extension RootViewController: UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageOperation = ImageOperation(photo: self.photoList[indexPath.row],
                                                dataRepositoryProtocol: self.dataRepositoryProtocol)
            self.operations[indexPath] = imageOperation
            self.operationQueue.addOperation(imageOperation)
        }
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let imageOperation = self.operations[indexPath] {
                imageOperation.cancel()
                self.operations[indexPath] = nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoTableViewCell = tableView.dequeueReusableCell(withIdentifier: ImageCellKey.key.rawValue)!
        if let imageOperation = self.operations[indexPath] {
            imageOperation.dataCompletion = { image in
                DispatchQueue.main.async {
                    var content = UIListContentConfiguration.cell()
                    content.image = image
                    photoTableViewCell.contentConfiguration = content
                }
            }
        } else {
            let imageOperation = ImageOperation(photo: self.photoList[indexPath.row],
                                                dataRepositoryProtocol: self.dataRepositoryProtocol)
            imageOperation.dataCompletion = { image in
                DispatchQueue.main.async {
                    var content = UIListContentConfiguration.cell()
                    content.image = image
                    photoTableViewCell.contentConfiguration = content
                }
            }
            self.operations[indexPath] = imageOperation
            self.operationQueue.addOperation(imageOperation)
        }
        return photoTableViewCell
    }
}

extension RootViewController {
    private enum ImageCellKey: String {
        case key = "cell"
    }
}


class ImageOperation: Operation {
    private let photo: Photo
    private let dataRepositoryProtocol: DataRepositoryProtocol?
    var dataCompletion: ((UIImage) -> Void)? = nil
    required init(photo: Photo, dataRepositoryProtocol: DataRepositoryProtocol?) {
        self.photo = photo
        self.dataRepositoryProtocol = dataRepositoryProtocol
    }
    
    override func start() {
        self.dataRepositoryProtocol?.getPhotoList(for: photo.url, completion: { dataRepositoryProtocolResult in
            switch dataRepositoryProtocolResult {
            case .success(let success):
                if let image = UIImage(data: success) {
                    self.dataCompletion?(image)
                }
            case .failure(let failure):
                print(failure)
            } }
        )
    }
}
