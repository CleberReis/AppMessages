//
//  ChatController.swift
//  Messages
//
//  Created by Cleber Reis on 15/04/21.
//

import UIKit

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    private let user: User
    
    // MARK: - Lifecycles
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        print("DEBUG: User is chat controller is \(user.username)")
    }
    
    // MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    }
}
