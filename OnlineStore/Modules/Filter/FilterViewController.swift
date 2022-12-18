//
//  FilterViewController.swift
//  OnlineStore
//
//  Created by Алиса Романова on 11.12.2022.
//

import SnapKit

final class FilterViewController: UIViewController {
    
    //MARK: - Properties
    
    //labels
    private let filterOptionsLabel = UILabel(text: "Filter options", font: .systemFont(ofSize: 17, weight: .semibold))
    private let brandLabel = UILabel(text: "Brand", font: .systemFont(ofSize: 17, weight: .semibold))
    private let priceLabel = UILabel(text: "Price", font: .systemFont(ofSize: 17, weight: .semibold))
    private let sizeLabel = UILabel(text: "Size", font: .systemFont(ofSize: 17, weight: .semibold))
    
    //buttons
    private let doneButton = UIButton(backgroundColor: UIColor(named: "orange"), title: "Done", textColor: .white, radius: 12)
    private let crossButton = UIButton(backgroundColor: .black, titntColor: .white, image: UIImage(systemName: "xmark"), radius: 9)
    private let brandButton = DropDownButton()
    private let priceButton = DropDownButton()
    private let sizeButton = DropDownButton()
    
    //views
    private let contentView = UIView(backgroundColor: .white, radius: 30)
    
    //stack
    private lazy var stackView = UIStackView(arrangedSubviews: [brandLabel, brandButton, priceLabel, priceButton, sizeLabel, sizeButton], spacing: 8, axis: .vertical)

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        setTitlesToButtons()
        setShadowsToContentView()
        addTargetsToButtons()
        
        setupConstraints()
    }
    
    //MARK: - setShadowsToContentView
    
    private func setShadowsToContentView() {
        contentView.layer.shadowColor = UIColor.systemGray.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }
    
    //MARK: - setTitlesToButtons
    
    private func setTitlesToButtons() {
        brandButton.setTitle(title: "Sumsung")
        priceButton.setTitle(title: "$300 - $500")
        sizeButton.setTitle(title: "4.5 to 5.5 inches")
    }
    
    //MARK: - addTargetsToButtons
    
    private func addTargetsToButtons() {
        brandButton.addTarget(self, action: #selector(showBrands), for: .touchUpInside)
        priceButton.addTarget(self, action: #selector(showPrice), for: .touchUpInside)
        crossButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }
    
    //MARK: - @objc methods
    
    @objc private func showBrands() {
        brandButton.setDropDownList(dataSource: ["IPhone", "Xiaomi", "Huawey", "Google Pixel", "Honor"])
    }
    
    @objc private func showPrice() {
        priceButton.setDropDownList(dataSource: ["$500 - $1000", "$500 - $1000", "$1000 - $2000", "$2000 - $5000", "$5000 - $10000"])
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

//MARK: - Setup constraints

extension FilterViewController {
    private func setupConstraints() {
        
        //contentView
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(375)
        }
        
        //crossButton
        
        contentView.addSubview(crossButton)
        
        crossButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(44)
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
            make.bottom.equalToSuperview().inset(60)
        }
    }
}
