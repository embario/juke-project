package fm.juke.mobile.ui.navigation

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import fm.juke.mobile.core.design.JukePalette
import fm.juke.mobile.core.design.components.JukeBackground
import fm.juke.mobile.core.design.components.JukeSpinner
import fm.juke.mobile.ui.auth.AuthRoute
import fm.juke.mobile.ui.session.SessionUiState
import fm.juke.mobile.ui.session.SessionViewModel
import androidx.lifecycle.viewmodel.compose.viewModel

@Composable
fun JukeApp(sessionViewModel: SessionViewModel = viewModel()) {
    val sessionState by sessionViewModel.uiState.collectAsStateWithLifecycle()
    when (val state = sessionState) {
        SessionUiState.Loading -> Splash()
        SessionUiState.SignedOut -> AuthRoute()
        is SessionUiState.SignedIn -> HomeScreen(session = state.snapshot, onLogout = sessionViewModel::logout)
    }
}

@Composable
private fun Splash() {
    JukeBackground {
        Column(
            modifier = Modifier.fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center,
        ) {
            JukeSpinner()
            Text(
                text = "Spinning up your crates...",
                style = MaterialTheme.typography.bodyMedium,
                color = JukePalette.Muted,
            )
        }
    }
}
