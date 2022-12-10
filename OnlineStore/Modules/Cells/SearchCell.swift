//
//  SearchCell.swift
//  OnlineStore
//
//  Created by Алиса Романова on 08.12.2022.
//

import SnapKit

class SearchCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let searchTextField = UITextField(placeholder: "Search")
    let searchView = UIView(backgroundColor: UIColor(named: "white")!, radius: 20)
    let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    let qrCodeButton = UIButton(backgroundColor: UIColor(named: "orange")!, titntColor: .white, image: UIImage(systemName: "qrcode"), radius: 17)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchImageView.tintColor = UIColor(named: "orange")
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup constraints

extension SearchCell {
    private func setupConstraints() {
        
        //searchView
        
        self.addSubview(searchView)
        
        searchView.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(300)
            make.left.equalToSuperview()
            make.top.equalToSuperview().inset(10)
        }
        
        //searchImageView
        
        searchView.addSubview(searchImageView)
        
        searchImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(8)
        }
        
        //searchTextField
        
        self.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(searchView)
        }
        
        //qrCodeButton
        
        self.addSubview(qrCodeButton)
        
        qrCodeButton.snp.makeConstraints { make in
            make.height.width.equalTo(35)
            make.left.equalTo(searchTextField.snp.right).offset(11)
            make.centerY.equalTo(searchView)
        }
    }
}
