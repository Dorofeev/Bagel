//
//  PacketsViewController.swift
//  BagelIos
//
//  Created by Andrey Dorofeev on 25.10.2021.
//  Copyright © 2021 Yagiz Lab. All rights reserved.
//

import UIKit

private let headerHeight: CGFloat = 44

private let statusColumnWidth = CGFloat(50.0)
private let methodColumnWidth = CGFloat(55.0)
private let dateColumnWidth = CGFloat(150.0)

class PacketsViewController: UIViewController {
    
    enum FilterTags: Int {
        case address, status, method
    }
    
    var viewModel: PacketsViewModel?
    var onPacketSelect : ((BagelPacket?) -> ())?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addressFilterTextField: UITextField!
    @IBOutlet weak var statusFilterTextField: UITextField!
    @IBOutlet weak var methodFilterTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        
        let barButton = UIBarButtonItem(image: LightTheme().clearIcon, style: .plain, target: self, action: #selector(clearButtonAction(_:)))
        
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Packets"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = LightTheme().controlBackgroundColor
        
        setupFilterTextFields()
        
        self.viewModel?.onChange = { [weak self] in
            self?.refresh()
        }
        
        tableView.register(
            UINib(
                nibName: "PacketTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "PacketTableViewCell"
        )
        
        let headerView = setupTableViewHeaders()
        tableView.tableHeaderView = headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalToConstant: tableView.frame.width)
        ])
    }
    
    private func setupFilterTextFields() {
        self.addressFilterTextField.backgroundColor = LightTheme().controlBackgroundColor
        self.addressFilterTextField.tag = FilterTags.address.rawValue
        addressFilterTextField.addTarget(
            self,
            action: #selector(textFieldValueChanged(_:)),
            for: .editingChanged
        )
        addressFilterTextField.placeholder = "Filter by URL"
        
        self.statusFilterTextField.backgroundColor = LightTheme().controlBackgroundColor
        self.statusFilterTextField.tag = FilterTags.status.rawValue
        statusFilterTextField.addTarget(
            self,
            action: #selector(textFieldValueChanged(_:)),
            for: .editingChanged
        )
        statusFilterTextField.placeholder = "Filter by status code"
        
        self.methodFilterTextField.backgroundColor = LightTheme().controlBackgroundColor
        self.methodFilterTextField.tag = FilterTags.method.rawValue
        methodFilterTextField.addTarget(
            self,
            action: #selector(textFieldValueChanged(_:)),
            for: .editingChanged
        )
        methodFilterTextField.placeholder = "Filter by method"
    }
    
    private func refresh() {
        self.tableView.reloadData()
        
        if let selectedItemIndex = self.viewModel?.selectedItemIndex {
            self.tableView.selectRow(
                at: IndexPath(item: selectedItemIndex, section: 0),
                animated: true,
                scrollPosition: .middle
            )
        }
        
        if isScrolledToBottom() {
            self.scrollToBottom()
        }
    }
    
    private func createHeaderColumnView(title: String, width: CGFloat, showSeparator: Bool = true) -> UIView {
        let columnView = UIView()
        columnView.translatesAutoresizingMaskIntoConstraints = false
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 12)
        columnView.addSubview(titleLabel)
        titleLabel.text = title
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        columnView.addSubview(separatorView)
        
        separatorView.isHidden = !showSeparator
        
        let widthConstraint = columnView.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.priority = width == 0 ? .defaultLow : .defaultHigh
        
        NSLayoutConstraint.activate([
            columnView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8),
            columnView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            columnView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            columnView.heightAnchor.constraint(equalToConstant: headerHeight),
            widthConstraint,
            columnView.trailingAnchor.constraint(equalTo: separatorView.trailingAnchor),
            columnView.topAnchor.constraint(equalTo: separatorView.topAnchor),
            columnView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 1)
        ])
        return columnView
    }
    
    private func setupTableViewHeaders() -> UIView {
        
        let statusCodeView = createHeaderColumnView(title: "Status", width: statusColumnWidth)
        let methodView = createHeaderColumnView(title: "Method", width: methodColumnWidth)
        let urlView = createHeaderColumnView(title: "URL", width: 0)
        let dateView = createHeaderColumnView(title: "Date", width: dateColumnWidth, showSeparator: false)
        
        let stack = UIStackView(arrangedSubviews: [statusCodeView, methodView, urlView, dateView])
        return stack
    }
    
    @objc private func clearButtonAction(_ sender: Any) {
        self.viewModel?.clearPackets()
    }
    
    @objc func textFieldValueChanged(_ sender: UITextField) {
        let tag = sender.tag
        guard let filterTag = FilterTags(rawValue: tag) else { return }
        
        switch filterTag {
            case .address:
                viewModel?.addressFilterTerm = addressFilterTextField.text ?? ""
            case .method:
                viewModel?.methodFilterTerm = methodFilterTextField.text ?? ""
            case .status:
                viewModel?.statusFilterTerm = statusFilterTextField.text ?? ""
        }
    }
}

extension PacketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.itemCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: "PacketTableViewCell", for: indexPath)
            as? PacketTableViewCell
            ?? PacketTableViewCell()
        
        cell.packet = self.viewModel?.item(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row >= 0, let item = self.viewModel?.item(at: indexPath.row) else {
            self.onPacketSelect?(nil)
            return
        }
        
        guard item !== self.viewModel?.selectedItem else { return }
        self.onPacketSelect?(item)
    }
}

extension PacketsViewController {
    
    func isScrolledToBottom() -> Bool {
        let itemsCount = viewModel?.items.count ?? 1
        return tableView.indexPathsForVisibleRows?.contains(
            IndexPath(item: max(itemsCount - 1, 1), section: 0)
        ) ?? true
    }
    
    func scrollToBottom() {
        let itemsCount = viewModel?.items.count ?? 1
        
        tableView.scrollToRow(at: IndexPath(item: max(itemsCount - 1, 1), section: 0), at: .bottom, animated: true)
    }
}
