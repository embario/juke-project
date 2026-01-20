package fm.juke.mobile.core.design.components

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import fm.juke.mobile.core.design.JukePalette

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun JukeChip(
    label: String,
    selected: Boolean,
    modifier: Modifier = Modifier,
    onClick: () -> Unit,
) {
    val shape = RoundedCornerShape(999.dp)
    Surface(
        onClick = onClick,
        shape = shape,
        color = if (selected) JukePalette.Accent.copy(alpha = 0.22f) else Color.Transparent,
        contentColor = if (selected) JukePalette.Panel else JukePalette.Muted,
        border = BorderStroke(1.1.dp, if (selected) JukePalette.Accent else JukePalette.Border),
        modifier = modifier,
    ) {
        Text(
            text = label,
            modifier = Modifier.padding(horizontal = 18.dp, vertical = 10.dp),
            style = MaterialTheme.typography.labelLarge.copy(fontWeight = FontWeight.SemiBold),
        )
    }
}
