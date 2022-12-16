//
//  SegmentButton.swift
//  OnlineStore
//
//  Created by Алиса Романова on 13.12.2022.
//

import SnapKit

final class SegmentButton: UIButton {
    
    //MARK: - Properties

    private let bottomView = UIView(backgroundColor: UIColor(named: "orange"))
    private let title = UILabel(font: .systemFont(ofSize: 20, weight: .medium), textColor: .gray, textAlignment: .center)

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    convenience init(title: String) {
        self.init()
        
        self.title.text = title
        self.title.numberOfLines = 1
        bottomView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setSelectedState() {
        title.font = .systemFont(ofSize: 20, weight: .bold)
        title.textColor = .black
        bottomView.isHidden = false
    }
    
    func setUnselectedState() {
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.textColor = .gray
        bottomView.isHidden = true
    }
}

//MARK: - Setup constraints

extension SegmentButton {
    private func setupConstraints() {
        
        //bottomView
        
        self.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(3)
        }
        
        //title
        
        self.addSubview(title)
        
        title.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
