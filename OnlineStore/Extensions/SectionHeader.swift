//
//  SectionHeader.swift
//  Chat
//
//  Created by Алиса Романова on 29.10.2022.
//

import SnapKit

final class SectionHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    let title = UILabel()
    let showMoreButton = UIButton(font: .systemFont(ofSize: 13, weight: .medium), textColor: UIColor(named: "orange"))
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func configure(text: String, font: UIFont?, buttonTitle: String) {
        title.textColor = .black
        title.font = font
        title.text = text
        
        showMoreButton.setTitle(buttonTitle, for: .normal)
    }
}

//MARK: - Setup constraints

extension SectionHeader {
    private func setupConstraints() {
        
        //title
        
        self.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        //showMoreButton
        
        self.addSubview(showMoreButton)
        
        showMoreButton.snp.makeConstraints { make in
            make.bottom.equalTo(title)
            make.right.equalToSuperview().inset(15)
        }
    }
}
