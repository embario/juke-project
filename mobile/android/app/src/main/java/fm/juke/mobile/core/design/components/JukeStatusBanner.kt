package fm.juke.mobile.core.design.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import fm.juke.mobile.core.design.JukePalette

enum class JukeStatusVariant { INFO, SUCCESS, WARNING, ERROR }

@Composable
fun JukeStatusBanner(
    message: String?,
    modifier: Modifier = Modifier,
    variant: JukeStatusVariant = JukeStatusVariant.INFO,
) {
    if (message.isNullOrBlank()) return
    val (accent, background) = when (variant) {
        JukeStatusVariant.INFO -> JukePalette.Accent to JukePalette.Accent.copy(alpha = 0.12f)
        JukeStatusVariant.SUCCESS -> JukePalette.Success to JukePalette.Success.copy(alpha = 0.18f)
        JukeStatusVariant.WARNING -> JukePalette.Warning to JukePalette.Warning.copy(alpha = 0.18f)
        JukeStatusVariant.ERROR -> JukePalette.Error to JukePalette.Error.copy(alpha = 0.2f)
    }
    val shape = RoundedCornerShape(18.dp)
    Row(
        modifier = modifier
            .fillMaxWidth()
            .background(color = background, shape = shape)
            .border(width = 1.dp, color = accent.copy(alpha = 0.35f), shape = shape)
            .padding(horizontal = 16.dp, vertical = 12.dp),
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Box(
            modifier = Modifier
                .size(12.dp)
                .background(accent, CircleShape),
        )
        Text(
            text = message,
            style = MaterialTheme.typography.bodyMedium,
            color = JukePalette.Text,
        )
    }
}
