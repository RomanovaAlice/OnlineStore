//
//  DropDownButton.swift
//  OnlineStore
//
//  Created by Алиса Романова on 11.12.2022.
//

import DropDown
import SnapKit

class DropDownButton: UIButton {

    //MARK: - Properties
    
    private let nameLabel = UILabel()
    private let dropDown = DropDown()
    private let downImageView = UIImageView(image: UIImage(systemName: "chevron.down"), tintColor: .gray)
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSelfAppearence()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setTitle(title: String) {
        nameLabel.text = title
    }
    
    func setDropDownList(dataSource: [String]) {
        dropDown.dataSource = dataSource
        dropDown.anchorView = self
        dropDown.bottomOffset = CGPoint(x: 0, y: self.frame.size.height)
        dropDown.show()
        
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.nameLabel.text = item
        }
    }
    
    private func setupSelfAppearence() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.borderWidth = 1
    }
}

//MARK: - Setup constraints

extension DropDownButton {
    private func setupConstraints() {
        
        //nameLabel
        
        self.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7)
            make.left.equalToSuperview().inset(14)
        }
        
        //downImageView
        
        self.addSubview(downImageView)
        
        downImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
}
