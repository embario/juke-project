package fm.shotclock.mobile

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import fm.shotclock.mobile.core.design.ShotClockTheme
import fm.shotclock.mobile.core.di.ServiceLocator
import fm.shotclock.mobile.ui.navigation.ShotClockApp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        ServiceLocator.init(applicationContext)
        enableEdgeToEdge()
        setContent {
            ShotClockTheme {
                ShotClockApp()
            }
        }
    }
}
