package fm.juke.mobile.core.design.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.input.VisualTransformation
import androidx.compose.ui.unit.dp
import fm.juke.mobile.core.design.JukePalette

@Composable
fun JukeInputField(
    label: String,
    value: String,
    onValueChange: (String) -> Unit,
    placeholder: String,
    modifier: Modifier = Modifier,
    error: String? = null,
    keyboardOptions: KeyboardOptions = KeyboardOptions.Default,
    keyboardActions: KeyboardActions = KeyboardActions.Default,
    visualTransformation: VisualTransformation = VisualTransformation.None,
    singleLine: Boolean = true,
) {
    Column(modifier = modifier, verticalArrangement = Arrangement.spacedBy(6.dp)) {
        Text(
            text = label.uppercase(),
            style = MaterialTheme.typography.labelSmall,
            color = JukePalette.Muted,
        )
        val shape = RoundedCornerShape(22.dp)
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .border(
                    width = 1.2.dp,
                    color = if (error != null) JukePalette.Error else JukePalette.Border,
                    shape = shape,
                )
                .background(JukePalette.PanelAlt.copy(alpha = 0.35f), shape),
        ) {
            TextField(
                value = value,
                onValueChange = onValueChange,
                modifier = Modifier
                    .fillMaxWidth(),
                textStyle = MaterialTheme.typography.bodyLarge,
                placeholder = { Text(text = placeholder, color = JukePalette.Muted) },
                singleLine = singleLine,
                keyboardOptions = keyboardOptions,
                keyboardActions = keyboardActions,
                visualTransformation = visualTransformation,
                shape = shape,
                isError = error != null,
                colors = TextFieldDefaults.colors(
                    focusedTextColor = JukePalette.Text,
                    unfocusedTextColor = JukePalette.Text,
                    disabledTextColor = JukePalette.Text.copy(alpha = 0.4f),
                    errorTextColor = JukePalette.Error,
                    focusedContainerColor = Color.Transparent,
                    unfocusedContainerColor = Color.Transparent,
                    disabledContainerColor = Color.Transparent,
                    errorContainerColor = Color.Transparent,
                    cursorColor = JukePalette.Accent,
                    errorCursorColor = JukePalette.Error,
                    focusedIndicatorColor = Color.Transparent,
                    unfocusedIndicatorColor = Color.Transparent,
                    disabledIndicatorColor = Color.Transparent,
                    errorIndicatorColor = Color.Transparent,
                    focusedPlaceholderColor = JukePalette.Muted,
                    unfocusedPlaceholderColor = JukePalette.Muted,
                    disabledPlaceholderColor = JukePalette.Muted.copy(alpha = 0.5f),
                    errorPlaceholderColor = JukePalette.Muted,
                ),
            )
        }
        if (!error.isNullOrBlank()) {
            Spacer(modifier = Modifier.height(2.dp))
            Text(
                text = error,
                style = MaterialTheme.typography.labelMedium,
                color = JukePalette.Error,
            )
        }
    }
}
