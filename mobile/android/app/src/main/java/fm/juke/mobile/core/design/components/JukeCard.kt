package fm.juke.mobile.core.design.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import fm.juke.mobile.core.design.JukePalette

@Composable
fun JukeCard(
    modifier: Modifier = Modifier,
    padding: PaddingValues = PaddingValues(24.dp),
    cornerRadius: Dp = 28.dp,
    borderColor: Color = JukePalette.Border,
    backgroundColors: List<Color> = listOf(
        JukePalette.Panel.copy(alpha = 0.95f),
        JukePalette.PanelAlt.copy(alpha = 0.92f),
    ),
    content: @Composable ColumnScope.() -> Unit,
) {
    val shape = RoundedCornerShape(cornerRadius)
    val gradient = Brush.linearGradient(
        colors = backgroundColors,
        start = Offset(0f, 0f),
        end = Offset(600f, 900f),
    )
    Box(
        modifier = modifier
            .shadow(
                elevation = 45.dp,
                shape = shape,
                clip = false,
                ambientColor = Color.Black.copy(alpha = 0.35f),
                spotColor = Color.Black.copy(alpha = 0.5f),
            )
            .clip(shape)
            .background(gradient)
            .border(width = 1.2.dp, color = borderColor, shape = shape),
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(padding),
            content = content,
        )
    }
}
