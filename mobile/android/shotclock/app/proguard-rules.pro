# kotlinx.serialization
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt
-keepclassmembers class kotlinx.serialization.json.** { *** Companion; }
-keepclasseswithmembers class kotlinx.serialization.json.** {
    kotlinx.serialization.KSerializer serializer(...);
}
-keep,includedescriptorclasses class fm.shotclock.mobile.**$$serializer { *; }
-keepclassmembers class fm.shotclock.mobile.** {
    *** Companion;
}
-keepclasseswithmembers class fm.shotclock.mobile.** {
    kotlinx.serialization.KSerializer serializer(...);
}
