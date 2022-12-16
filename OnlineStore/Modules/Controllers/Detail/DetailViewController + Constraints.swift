//
//  DetailViewController + Constraints.swift
//  OnlineStore
//
//  Created by Алиса Романова on 15.12.2022.
//

import SnapKit

extension DetailViewController {
    func setupConstraints() {
        
        //backButton
        
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(42)
            make.top.equalToSuperview().inset(79)
            make.height.width.equalTo(37)
        }
        
        //titleLabel
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.left.equalTo(backButton.snp.right).offset(51)
        }
        
        //cartButton
        
        view.addSubview(cartButton)
        
        cartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(79)
            make.right.equalToSuperview().inset(35)
            make.width.height.equalTo(37)
        }
        
        //carouselView
        
        view.addSubview(carouselView)
        
        carouselView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(130)
            make.height.equalTo(310)
        }
        
        //productInformationView
        
        view.addSubview(productInformationView)
        
        productInformationView.snp.makeConstraints { make in
            make.top.equalTo(carouselView.snp.bottom).offset(7)
            make.left.right.bottom.equalToSuperview()
        }
        
        //favoriteButton
        
        productInformationView.addSubview(favoriteButton)
        
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.right.equalToSuperview().inset(37)
            make.top.equalToSuperview().inset(28)
        }
        
        //phoneNameLabel
        
        productInformationView.addSubview(phoneNameLabel)
        
        phoneNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(38)
            make.top.equalToSuperview().inset(28)
        }
        
        //fiveStarsImageView

        view.addSubview(fiveStarsImageView)

        fiveStarsImageView.snp.makeConstraints { make in
            make.top.equalTo(phoneNameLabel.snp.bottom).offset(3)
            make.left.equalToSuperview().inset(30)
            make.height.equalTo(30)
            make.width.equalTo(140)
        }
        
        //segmentStackVeiw
        
        productInformationView.addSubview(segmentStackVeiw)
        
        segmentStackVeiw.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.top.equalTo(fiveStarsImageView.snp.bottom).offset(23)
        }

        //addToCartButton

        productInformationView.addSubview(addToCartButton)
        
        addToCartButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(54)
        }
        
        //selectColorAndCapacityLabel
        
        productInformationView.addSubview(selectColorAndCapacityLabel)
        
        selectColorAndCapacityLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.bottom.equalTo(addToCartButton.snp.top).offset(-81)
        }
        
        //accessoryImages
        
        productInformationView.addSubview(gpuImageView)
        
        gpuImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(44)
            make.height.width.equalTo(25)
            make.top.equalToSuperview().inset(155)
        }
        
        productInformationView.addSubview(cameraImageView)
        
        cameraImageView.snp.makeConstraints { make in
            make.height.bottom.equalTo(gpuImageView)
            make.width.equalTo(30)
            make.left.equalTo(gpuImageView.snp.right).offset(65)
        }
        
        productInformationView.addSubview(ssdImageView)
        
        ssdImageView.snp.makeConstraints { make in
            make.height.width.bottom.equalTo(gpuImageView)
            make.left.equalTo(cameraImageView.snp.right).offset(65)
        }
        
        productInformationView.addSubview(sdImageView)
        
        sdImageView.snp.makeConstraints { make in
            make.height.width.bottom.equalTo(gpuImageView)
            make.left.equalTo(ssdImageView.snp.right).offset(65)
        }
        
        //accessoryTitlesStackView
        
        productInformationView.addSubview(accessoryTitlesStackView)

        accessoryTitlesStackView.snp.makeConstraints { make in
            make.top.equalTo(gpuImageView.snp.bottom).offset(7)
            make.left.equalToSuperview().inset(30)
        }
        
        //brownColorButton
        
        productInformationView.addSubview(brownColorButton)
        
        brownColorButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(34)
            make.height.width.equalTo(40)
            make.top.equalTo(selectColorAndCapacityLabel.snp.bottom).offset(14)
        }
        
        //blueColorButton
        
        productInformationView.addSubview(blueColorButton)
        
        blueColorButton.snp.makeConstraints { make in
            make.left.equalTo(brownColorButton.snp.right).offset(18)
            make.height.width.equalTo(40)
            make.top.equalTo(selectColorAndCapacityLabel.snp.bottom).offset(14)
        }
        
        //memoryStackView
        
        productInformationView.addSubview(memoryStackView)
        
        memoryStackView.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(150)
            make.right.equalToSuperview().inset(57)
            make.top.equalTo(selectColorAndCapacityLabel.snp.bottom).offset(17)
        }
    }
}
