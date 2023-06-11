//
//  ViewController.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 11/06/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    private var model: [UserResponse]?
    private var api = RequestAPI()

    var isUnitTesting: Bool = false
    var isUITesting: Bool = false

    @IBOutlet weak var storeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.storeCollectionView.dataSource = self
        self.storeCollectionView.delegate = self
        storeCollectionView.dataSource = self
        getResponse()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }


    func getResponse() {
        if isUnitTesting || isUITesting {
            api.fetchFromMock {[weak self] modelResult in
                self?.model = modelResult
                DispatchQueue.main.async {
                    self?.storeCollectionView.reloadData()
                }
            }
        } else {
            api.fetch {[weak self] modelResult in
                self?.model = modelResult
                DispatchQueue.main.async {
                    self?.storeCollectionView.reloadData()
                }
            }
        }
    }

    fileprivate func presentView(url: String) {
        guard let nvc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        nvc.urlGit = url
        self.present(nvc, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = model {
            return items.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as? UsersCollectionViewCell {
            if let spotlight = model?[indexPath.item] {
                cell.product = spotlight
            }
            cell.backgroundColor = UIColor.black
            cell.layer.borderWidth = 1
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowRadius = 2.0
            cell.layer.cornerRadius = 10
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 2000, height: 40)
            cell.layer.shadowRadius = 2.0
            return cell
        } else {
            return UsersCollectionViewCell()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presentView(url: model?[indexPath.item].html_url ?? "")
    }
}
