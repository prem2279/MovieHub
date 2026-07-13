//
//  MovieChatViewController.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 7/13/26.
//

import UIKit

class MovieChatViewController: UIViewController {

    //MARK: - Properties

    var viewModel: MovieChatDelegate!
    weak var coordinator: NavigationCordinatorProtocol?

    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()

    private let inputContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()

    private let inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Ask for movies…"
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .send
        return textField
    }()

    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        chatTableView.register(ChatMessageCell.self, forCellReuseIdentifier: TableViewCells.chatMessageCell)
        chatTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: TableViewCells.movieCell)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        inputTextField.delegate = self
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)

        setupUI()
        viewModel.prewarm()
    }
}

//MARK: - Sending the Message

extension MovieChatViewController {

    @objc private func sendTapped() {

        guard let userInput = inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !userInput.isEmpty else { return }

        inputTextField.text = ""

        viewModel.send(userInput: userInput) {
            [weak self] in
            DispatchQueue.main.async {
                self?.reloadChat()
            }
        }
    }

    private func reloadChat() {
        chatTableView.reloadData()

        let lastRow = viewModel.getItemsCount() - 1
        if lastRow >= 0 {
            chatTableView.scrollToRow(at: IndexPath(row: lastRow, section: 0), at: .bottom, animated: true)
        }
    }
}

//MARK: - UI SetUp Methods

extension MovieChatViewController {

    private func setupUI() {
        view.backgroundColor = .black

        view.addSubview(chatTableView)
        view.addSubview(inputContainer)
        inputContainer.addSubview(inputTextField)
        inputContainer.addSubview(sendButton)

        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor),

            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Keeps the input bar above the keyboard when it appears
            inputContainer.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),

            inputTextField.topAnchor.constraint(equalTo: inputContainer.topAnchor, constant: 8),
            inputTextField.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor, constant: -8),
            inputTextField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 16),

            sendButton.leadingAnchor.constraint(equalTo: inputTextField.trailingAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -16),
            sendButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 36),
            sendButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
}

//MARK: - Text Field Delegate

extension MovieChatViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendTapped()
        return true
    }
}

//MARK: - Data Source Methods

extension MovieChatViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getItemsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let item = viewModel.getItem(at: indexPath.row) else {
            return UITableViewCell()
        }

        switch item {
        case .userMessage(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.chatMessageCell, for: indexPath) as? ChatMessageCell
            cell?.configure(text: text, isUser: true)
            return cell ?? UITableViewCell()

        case .botMessage(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.chatMessageCell, for: indexPath) as? ChatMessageCell
            cell?.configure(text: text, isUser: false)
            return cell ?? UITableViewCell()

        case .typing:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.chatMessageCell, for: indexPath) as? ChatMessageCell
            cell?.configure(text: "Thinking…", isUser: false)
            return cell ?? UITableViewCell()

        case .movie(let movie):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCells.movieCell, for: indexPath) as? MovieTableViewCell
            cell?.configure(with: MovieDetailsViewModel(movie: movie))
            return cell ?? UITableViewCell()
        }
    }
}

//MARK: - Delegate Methods

extension MovieChatViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard case .movie(let movie) = viewModel.getItem(at: indexPath.row) else { return }

        // Closes the chat sheet before navigating to the details page
        let coordinator = self.coordinator
        dismiss(animated: true) {
            coordinator?.navigateToMovieDetails(movie: movie)
        }
    }
}
