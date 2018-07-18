//
//  TimeSettingView.swift
//  BoardTimer
//
//  Created by 파디오 on 13/07/2018.
//  Copyright © 2018 파디오. All rights reserved.
//

import UIKit

class TimeSettingView: UIViewController,UINavigationControllerDelegate{
    let MAX_NUM:[Int] = [100, 10]
    @IBOutlet weak var pickerView: UIPickerView!
    
    var select_picker:[Int] = [0,0]
    
    override func viewDidLoad() {
       
        self.pickerView.delegate = self
        
        self.pickerView.selectRow(UserDefaults.standard.integer(forKey: "starttime"), inComponent: 0, animated: true)
        self.pickerView.selectRow(UserDefaults.standard.integer(forKey: "waittime"), inComponent: 1, animated: true)
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.DoneAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(self.BackAction))
    }

    @objc func DoneAction(){
        UserDefaults.standard.setValue(select_picker[0], forKey: "starttime")
        UserDefaults.standard.setValue(select_picker[1], forKey: "waittime")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func BackAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension TimeSettingView: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return MAX_NUM.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MAX_NUM[component]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        select_picker[component] = row
        print("select picker \(select_picker)")
    }
    
}
