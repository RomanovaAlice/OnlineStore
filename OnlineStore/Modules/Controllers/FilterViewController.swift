//
//  FilterViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 11.12.2022.
//

import SnapKit

class FilterViewController: UIViewController {
    
    //MARK: - Properties
    
    private let contentView = UIView(backgroundColor: .white, radius: 15)
    
    //labels
    private let filterOptionsLabel = UILabel(text: "Filter options", font: .systemFont(ofSize: 17, weight: .semibold))
    private let brandLabel = UILabel(text: "Brand")
    private let priceLabel = UILabel(text: "Price")
    private let sizeLabel = UILabel(text: "Size")
    
    //buttons
    private let doneButton = UIButton(backgroundColor: UIColor(named: "orange"), title: "Done", textColor: .white, radius: 12)
    private let crossButton = UIButton(backgroundColor: .black, titntColor: .white, image: UIImage(systemName: "xmark"), radius: 7)
    private let modelButton = DropDownButton()
    private let priceButton = DropDownButton()
    private let sizeButton = DropDownButton()
    
    //stack
    private lazy var stackView = UIStackView(arrangedSubviews: [brandLabel, modelButton, priceLabel, priceButton, sizeLabel, sizeButton])

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        setShadows()
        configureStackView()
        
        setupConstraints()
    }
    
    //MARK: - setShadows
    
    private func setShadows() {
        contentView.layer.shadowColor = UIColor.systemGray.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
    }

}

//MARK: - Setup constraints

extension FilterViewController {
    private func setupConstraints() {
        
        //contentView
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
            make.height.equalTo(375)
        }
        
        //crossButton
        
        contentView.addSubview(crossButton)
        
        crossButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(24)
            make.height.width.equalTo(37)
        }
        
        //doneButton
        
        contentView.addSubview(doneButton)
        
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(20)
            make.width.equalTo(86)
            make.height.equalTo(37)
        }
        
        //filterOptionsLabel
        
        contentView.addSubview(filterOptionsLabel)
        
        filterOptionsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(31)
            make.centerX.equalToSuperview()
            make.height.equalTo(23)
            make.width.equalTo(114)
        }
        
        //stackView
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(46)
            make.top.equalTo(crossButton.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(31)
        }
    }
}
