package fm.juke.mobile.ui.auth

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import fm.juke.mobile.core.di.ServiceLocator
import fm.juke.mobile.data.network.humanReadableMessage
import fm.juke.mobile.data.repository.AuthRepository
import kotlinx.coroutines.launch

enum class AuthMode { LOGIN, REGISTER }

data class AuthUiState(
    val mode: AuthMode = AuthMode.LOGIN,
    val username: String = "",
    val email: String = "",
    val password: String = "",
    val confirmPassword: String = "",
    val isLoading: Boolean = false,
    val message: String? = null,
    val error: String? = null,
)

class AuthViewModel(
    private val repository: AuthRepository = ServiceLocator.authRepository,
) : ViewModel() {

    var uiState by mutableStateOf(AuthUiState())
        private set

    fun updateUsername(value: String) {
        uiState = uiState.copy(username = value, error = null, message = null)
    }

    fun updateEmail(value: String) {
        uiState = uiState.copy(email = value, error = null, message = null)
    }

    fun updatePassword(value: String) {
        uiState = uiState.copy(password = value, error = null, message = null)
    }

    fun updateConfirmPassword(value: String) {
        uiState = uiState.copy(confirmPassword = value, error = null, message = null)
    }

    fun toggleMode() {
        uiState = uiState.copy(
            mode = if (uiState.mode == AuthMode.LOGIN) AuthMode.REGISTER else AuthMode.LOGIN,
            message = null,
            error = null,
        )
    }

    fun submit() {
        if (uiState.mode == AuthMode.LOGIN) {
            login()
        } else {
            register()
        }
    }

    private fun login() {
        viewModelScope.launch {
            uiState = uiState.copy(isLoading = true, error = null, message = null)
            val username = uiState.username.trim()
            val password = uiState.password
            repository.login(username, password)
                .onSuccess {
                    uiState = uiState.copy(
                        isLoading = false,
                        password = "",
                        message = "Signed in as $username",
                    )
                }
                .onFailure { throwable ->
                    uiState = uiState.copy(isLoading = false, error = throwable.humanReadableMessage())
                }
        }
    }

    private fun register() {
        viewModelScope.launch {
            uiState = uiState.copy(isLoading = true, error = null, message = null)
            val username = uiState.username.trim()
            val email = uiState.email.trim()
            val password = uiState.password
            val confirm = uiState.confirmPassword
            repository.register(username, email, password, confirm)
                .onSuccess { detail ->
                    uiState = uiState.copy(
                        isLoading = false,
                        message = detail,
                        mode = AuthMode.LOGIN,
                        password = "",
                        confirmPassword = "",
                    )
                }
                .onFailure { throwable ->
                    uiState = uiState.copy(isLoading = false, error = throwable.humanReadableMessage())
                }
        }
    }
}
