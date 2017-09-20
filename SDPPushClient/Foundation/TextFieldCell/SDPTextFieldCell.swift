//
//  SDPTextFieldCell.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/20.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit

@objc protocol SDPTextFieldCellDelegate {
    @objc optional func textFieldCellEndEdit(textFieldCell:SDPTextFieldCell, text:String)
}

class SDPTextFieldCell: UITableViewCell,UITextFieldDelegate {
    
    open var tfInput:UITextField = UITextField()
    
    open var delegate:SDPTextFieldCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tfInput.delegate = self
        self.contentView.addSubview(tfInput)
        tfInput.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(kSDPPadding)
            make.trailing.equalToSuperview().offset(-kSDPPadding)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldCellEndEdit!(textFieldCell: self, text: textField.text!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
