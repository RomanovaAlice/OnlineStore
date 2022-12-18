//
//  CartViewController + Constraints.swift
//  OnlineStore
//
//  Created by Алиса Романова on 13.12.2022.
//

import SnapKit

extension CartViewController {
    func setupConstraints() {
        
        //titleLabel
        
        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(42)
            make.top.equalToSuperview().inset(166)
        }
        
        //backButton

        view.addSubview(backButton)

        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(42)
            make.top.equalToSuperview().inset(79)
            make.height.width.equalTo(37)
        }

        //locationButton

        view.addSubview(locationButton)

        locationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(79)
            make.right.equalToSuperview().inset(35)
            make.width.height.equalTo(37)
        }
        
        //addAddressLabel

        view.addSubview(addAddressLabel)

        addAddressLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(85)
            make.top.equalToSuperview().inset(88)
        }
        
        //contentView
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(260)
        }
        
        //cartCollectionView
        
        contentView.addSubview(cartCollectionView)
        
        cartCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(217)
            make.top.equalToSuperview().inset(40)
        }
        
        //checkuotButton
        
        contentView.addSubview(checkuotButton)
        
        checkuotButton.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(44)
            make.height.equalTo(54)
        }

        //bottomSeparatorView

        contentView.addSubview(bottomSeparatorView)

        bottomSeparatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.4)
            make.bottom.equalToSuperview().inset(125)
        }
        
        //topSeparatorView

        contentView.addSubview(topSeparatorView)

        topSeparatorView.snp.makeConstraints { make in
            make.height.equalTo(0.7)
            make.left.right.equalToSuperview()
            make.top.equalTo(bottomSeparatorView).offset(-91)
        }

        //totalLabel

        contentView.addSubview(totalLabel)

        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(topSeparatorView).offset(17)
            make.left.equalToSuperview().inset(50)
        }

        //deliveryLabel

        contentView.addSubview(deliveryLabel)

        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(50)
        }

        //totalPriceLabel

        contentView.addSubview(totalPriceLabel)

        totalPriceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(35)
            make.top.equalTo(topSeparatorView).offset(15)
        }

        //freeLabel

        contentView.addSubview(freeLabel)

        freeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(35)
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(17)
        }
    }
}
