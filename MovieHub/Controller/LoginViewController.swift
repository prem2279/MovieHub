
//
//  LoginViewController.swift
//  MovieHub
//

import UIKit
import FirebaseCrashlytics

enum AppTheme: String {
    case light
    case dark
}

class LoginViewController: UIViewController {

    weak var coordinator: NavigationCordinatorProtocol?

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MovieHub"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome Back"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()

    private let userName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        return textField
    }()

    private let password: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()

    private let rememberMeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Remember Me"
        return label
    }()

    private let rememberSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    private let darkModeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dark Mode"
        return label
    }()

    private let darkModeSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.filled()
        config.title = "Login"
        config.cornerStyle = .large

        button.configuration = config
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupUI()
        configureSavedValues()
        applyTheme()
    }

    // MARK: - Setup

    private func setupUI() {

        styleTextField(userName)
        styleTextField(password)

        view.addSubview(cardView)

        let rememberStack = UIStackView(arrangedSubviews: [
            rememberMeLabel,
            rememberSwitch
        ])

        rememberStack.axis = .horizontal
        rememberStack.distribution = .equalSpacing

        let themeStack = UIStackView(arrangedSubviews: [
            darkModeLabel,
            darkModeSwitch
        ])

        themeStack.axis = .horizontal
        themeStack.distribution = .equalSpacing

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            userName,
            password,
            rememberStack,
            themeStack,
            loginButton
        ])

        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20

        cardView.addSubview(stack)

        NSLayoutConstraint.activate([

            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            stack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            stack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            stack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            userName.heightAnchor.constraint(equalToConstant: 50),
            password.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        loginButton.addTarget(
            self,
            action: #selector(saveUserName),
            for: .touchUpInside
        )

        darkModeSwitch.addTarget(
            self,
            action: #selector(themeChanged),
            for: .valueChanged
        )
    }

    private func styleTextField(_ textField: UITextField) {

        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = .tertiarySystemBackground

        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        textField.leftView = padding
        textField.leftViewMode = .always
    }

    // MARK: - UserDefaults

    private func configureSavedValues() {

        if let savedUserName = UserDefaults.standard.string(forKey: "userName") {
            userName.text = savedUserName
            rememberSwitch.isOn = true
        }

        let theme =
            UserDefaults.standard.string(forKey: "theme") ?? AppTheme.light.rawValue

        darkModeSwitch.isOn = theme == AppTheme.dark.rawValue
    }

    @objc
    private func saveUserName() {
        //fatalError("Crashlytics test crash")
        if rememberSwitch.isOn {
            UserDefaults.standard.set(
                userName.text,
                forKey: "userName"
            )
        } else {
            UserDefaults.standard.removeObject(
                forKey: "userName"
            )
        }

        coordinator?.home()
    }

    // MARK: - Theme

    @objc
    private func themeChanged() {

        let theme: AppTheme =
            darkModeSwitch.isOn ? .dark : .light

        UserDefaults.standard.set(
            theme.rawValue,
            forKey: "theme"
        )

        applyTheme()
    }

    private func applyTheme() {

        let theme =
            UserDefaults.standard.string(forKey: "theme")
            ?? AppTheme.light.rawValue

        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            return
        }

        window.overrideUserInterfaceStyle =
            theme == AppTheme.dark.rawValue ? .dark : .light
    }
}


