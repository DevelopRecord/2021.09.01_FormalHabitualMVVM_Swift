//
//  AddHabitualController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

// Habituals - title, timestamp, dayOfTheWeek, time, alertMusic, ownUid

import UIKit
import SnapKit

protocol AddHabitualControllerDelegate: AnyObject {
    func controllerDidFinishUploadingHabitual(_ controller: AddHabitualController)
}

class AddHabitualController: UIViewController, UIActionSheetDelegate {
    
    var habitual: Habitual?
    
    weak var delegate: AddHabitualControllerDelegate?
    
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }
    
    // MARK: Properties
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let newHabitual: UILabel = {
        let label = UILabel()
        label.text = "New Habitual"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    private lazy var titleTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "새로운 습관의 이름을 작성해 보세요\n ex) 운동, 공부, 물 마시기"
        tv.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.textAlignment = .center
        tv.layer.cornerRadius = 20
        tv.setDimensions(height: 90, width: view.frame.width - 50)
        
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/50"
        return label
    }()
    
    private let sundayButton: UIButton = {
        let button = CustomButton()
        button.isSelected = true
        button.setTitle("SUN", for: .normal)
        button.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "dayBorderColor")?.cgColor
        button.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: #selector(sunBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let mondayButton: UIButton = {
        let button = CustomButton()
        button.isSelected = true
        button.setTitle("MON", for: .normal)
        button.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "dayBorderColor")?.cgColor
        button.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: #selector(monBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let thuesdayButton: UIButton = {
        let button = CustomButton()
        button.isSelected = true
        button.setTitle("TUE", for: .normal)
        button.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "dayBorderColor")?.cgColor
        button.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: #selector(tueBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let wednesdayButton: UIButton = {
        let button = CustomButton()
        button.isSelected = true
        button.setTitle("WED", for: .normal)
        button.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "dayBorderColor")?.cgColor
        button.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: #selector(wedBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let thursdayButton: UIButton = {
        let button = CustomButton()
        button.isSelected = true
        button.setTitle("THR", for: .normal)
        button.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "dayBorderColor")?.cgColor
        button.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: #selector(thrBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let fridayButton: UIButton = {
        let button = CustomButton()
        button.isSelected = true
        button.setTitle("FRI", for: .normal)
        button.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "dayBorderColor")?.cgColor
        button.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: #selector(friBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let saturdayButton: UIButton = {
        let button = CustomButton()
        button.isSelected = true
        button.setTitle("SAT", for: .normal)
        button.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "dayBorderColor")?.cgColor
        button.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.addTarget(self, action: #selector(satBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private let notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var onOffButton: UIButton = {
        let button = CustomActionSheetButton()
        button.setTitle("ON", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        button.setWidth(view.frame.width - 50)
        button.addTarget(self, action: #selector(onOffButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var timeButton: UIButton = {
        let button = CustomActionSheetButton()
        button.setTitle("시간", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        button.setWidth(view.frame.width - 50)
        button.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let notiSoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification Sound"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var notiSoundButton: UIButton = {
        let button = CustomActionSheetButton()
        button.setTitle("알림음", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        button.setWidth(view.frame.width - 50)
        button.addTarget(self, action: #selector(frequencyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        button.layer.cornerRadius = 20
        button.setDimensions(height: 50, width: 180)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONFIRM", for: .normal)
        button.setTitleColor(UIColor(named: "labelColor"), for: .normal)
        button.backgroundColor = UIColor(named: "UIViewBackgroundColor")
        button.layer.cornerRadius = 20
        button.setHeight(50)
        button.setWidth(180)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
        self.moveViewWithKeyboard()
    }
    
    // MARK: Helper
    
    func checkMaxLength(_ textView: UITextView) {
        if textView.text.count > 50 {
            textView.deleteBackward()
        }
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        let topStack = UIStackView(arrangedSubviews: [newHabitual, titleTextView, characterCountLabel])
        topStack.axis = .vertical
        topStack.spacing = 10
        
        let countStack = UIStackView(arrangedSubviews: [characterCountLabel])
        countStack.axis = .horizontal
        
        let dayStack = UIStackView(arrangedSubviews: [sundayButton, mondayButton, thuesdayButton,
                                                    wednesdayButton, thursdayButton,fridayButton, saturdayButton])
        dayStack.axis = .horizontal
        dayStack.spacing = 11.2
        
        let notificationStack = UIStackView(arrangedSubviews: [notificationLabel, dayStack, onOffButton, timeButton])
        notificationStack.axis = .vertical
        notificationStack.spacing = 10
        
        let notiSoundStack = UIStackView(arrangedSubviews: [notiSoundLabel, notiSoundButton])
        notiSoundStack.axis = .vertical
        notiSoundStack.spacing = 10
        
        let btnStack = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        btnStack.axis = .horizontal
        btnStack.spacing = 7
        
        let wholeStack = UIStackView(arrangedSubviews: [topStack, countStack, dayStack, notificationStack, notiSoundStack])
        wholeStack.axis = .vertical
        wholeStack.spacing = 20
        
        view.addSubview(wholeStack)
        wholeStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
        }
        
        view.addSubview(btnStack)
        btnStack.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalTo(view)
        }
    }
    
    // MARK: Actions
    
    @objc func confirmButtonTapped(_ sender: UIButton) {
        guard let title = titleTextView.text else { return }
        guard let selectedTime = timeButton.titleLabel?.text else { return }
        
        if title.count == 0 {
            self.showMessage(withTitle: "알림", message: "습관 이름을 입력해 주세요.")
            return
        }
        
        showLoader(true)
        
        HabitualService.uploadHabitual(title: title, selectedTime: selectedTime) { error in
            self.showLoader(false)
            
            if let error = error {
                print("DEBUG: Failed to upload Habitual with error..\(error.localizedDescription)")
                return
            }
            self.delegate?.controllerDidFinishUploadingHabitual(self)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func frequencyButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let basicMusic = UIAlertAction(title: "기본", style: .default, handler: nil)
        let etc1Music = UIAlertAction(title: "뮤직1", style: .default, handler: nil)
        let etc2Music = UIAlertAction(title: "뮤직2", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(basicMusic)
        alert.addAction(etc1Music)
        alert.addAction(etc2Music)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onOffButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            timeButton.isEnabled = true
            onOffButton.setTitle("ON", for: .normal)
            self.timeButton.alpha = 1
        } else {
            sender.isSelected = true
            timeButton.isEnabled = false
            onOffButton.setTitle("OFF", for: .normal)
            self.timeButton.alpha = 0.3
        }
    }
    
    @objc func timeButtonTapped() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en_GB")
        let datestr = "00:00"
        let dateform = DateFormatter()
        dateform.dateFormat = "HH:mm"
        
        let datetime = dateform.date(from: datestr)
        if let unwrappedDate = datetime {
            datePicker.setDate(unwrappedDate, animated: true)
        }
        
        let alert = UIAlertController(title: "Pick a time", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(alert.view.snp.top).offset(40)
            make.width.equalTo(alert.view.frame.width - 10)
            make.centerX.equalTo(alert.view)
        }
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { alertAction in
                                        self.timeButton.setTitle("\(dateform.string(from: datePicker.date))",
                                        for: .normal)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // actionSheet Constraint
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 380)
        alert.view.addConstraint(height)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func sunBtnTapped(_ sender: UIButton, date: NSDate, id: Int) {
        if sender.isSelected {
            sender.isSelected = false
            sundayButton.setTitleColor(UIColor(named: "dayButtonIsSelectedLabelColor"), for: .normal)
            sundayButton.backgroundColor = UIColor(named: "dayButtonIsSelectedBackgroundColor")
        } else {
            sender.isSelected = true
            sundayButton.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
            sundayButton.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        }
    }
    
    @objc func monBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            // ON
            sender.isSelected = false
            mondayButton.setTitleColor(UIColor(named: "dayButtonIsSelectedLabelColor"), for: .normal)
            mondayButton.backgroundColor = UIColor(named: "dayButtonIsSelectedBackgroundColor")
        } else {
            // OFF
            sender.isSelected = true
            mondayButton.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
            mondayButton.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        }
    }
    
    @objc func tueBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            thuesdayButton.setTitleColor(UIColor(named: "dayButtonIsSelectedLabelColor"), for: .normal)
            thuesdayButton.backgroundColor = UIColor(named: "dayButtonIsSelectedBackgroundColor")
        } else {
            sender.isSelected = true
            thuesdayButton.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
            thuesdayButton.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        }
    }
    
    @objc func wedBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            wednesdayButton.setTitleColor(UIColor(named: "dayButtonIsSelectedLabelColor"), for: .normal)
            wednesdayButton.backgroundColor = UIColor(named: "dayButtonIsSelectedBackgroundColor")
        } else {
            sender.isSelected = true
            wednesdayButton.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
            wednesdayButton.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        }
    }
    
    @objc func thrBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            thursdayButton.setTitleColor(UIColor(named: "dayButtonIsSelectedLabelColor"), for: .normal)
            thursdayButton.backgroundColor = UIColor(named: "dayButtonIsSelectedBackgroundColor")
        } else {
            sender.isSelected = true
            thursdayButton.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
            thursdayButton.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        }
    }
    
    @objc func friBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            fridayButton.setTitleColor(UIColor(named: "dayButtonIsSelectedLabelColor"), for: .normal)
            fridayButton.backgroundColor = UIColor(named: "dayButtonIsSelectedBackgroundColor")
        } else {
            sender.isSelected = true
            fridayButton.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
            fridayButton.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        }
    }
    
    @objc func satBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            saturdayButton.setTitleColor(UIColor(named: "dayButtonIsSelectedLabelColor"), for: .normal)
            saturdayButton.backgroundColor = UIColor(named: "dayButtonIsSelectedBackgroundColor")
        } else {
            sender.isSelected = true
            saturdayButton.setTitleColor(UIColor(named: "dayButtonIsUnSelectedLabelColor"), for: .normal)
            saturdayButton.backgroundColor = UIColor(named: "dayButtonIsUnSelectedBackgroundColor")
        }
    }
}

// MARK: UITextViewDelegate

extension AddHabitualController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/50"
    }
}
