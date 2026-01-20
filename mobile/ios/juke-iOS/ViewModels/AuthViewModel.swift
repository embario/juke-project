import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    @Published var isRegistering: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    private let session: SessionStore

    init(session: SessionStore) {
        self.session = session
    }

    func setMode(registering: Bool) {
        guard registering != isRegistering else { return }
        isRegistering = registering
        errorMessage = nil
        successMessage = nil
    }

    func submit() async {
        errorMessage = nil
        successMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            if isRegistering {
                guard password == passwordConfirm else {
                    errorMessage = "Passwords do not match."
                    return
                }
                let message = try await session.register(
                    username: username,
                    email: email,
                    password: password,
                    passwordConfirm: passwordConfirm
                )
                successMessage = message
                password = ""
                passwordConfirm = ""
                isRegistering = false
            } else {
                try await session.login(username: username, password: password)
                password = ""
                passwordConfirm = ""
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
