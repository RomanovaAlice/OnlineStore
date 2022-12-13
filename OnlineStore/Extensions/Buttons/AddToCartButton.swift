//
//  AddToCartButton.swift
//  OnlineStore
//
//  Created by Алиса Романова on 13.12.2022.
//

import SnapKit

class AddToCartButton: UIButton {
    
    //MARK: - Properties


    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
}

//MARK: - Setup constraints

extension AddToCartButton {
    private func setupConstraints() {
        
    }
}
