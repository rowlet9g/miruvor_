import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val signingPropertiesFile = rootProject.file("key.properties")
val signingProperties = Properties().apply {
    if (signingPropertiesFile.isFile) {
        signingPropertiesFile.inputStream().use { load(it) }
    }
}

val checkReleaseSigning by tasks.registering {
    doLast {
        check(signingPropertiesFile.isFile) {
            "Release signing is not configured. See docs/releasing.md."
        }
        for (key in listOf("storeFile", "storePassword", "keyAlias", "keyPassword")) {
            check(!signingProperties.getProperty(key).isNullOrBlank()) {
                "Missing release signing property: $key"
            }
        }
        check(rootProject.file(signingProperties.getProperty("storeFile")).isFile) {
            "Release keystore file does not exist. See docs/releasing.md."
        }
    }
}

tasks.configureEach {
    if (name == "preReleaseBuild") dependsOn(checkReleaseSigning)
}

android {
    namespace = "com.example.miruvor"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Keep the existing identity for this initial direct-download release.
        // Changing it creates a separate app with a separate local database.
        applicationId = "com.example.miruvor"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = signingProperties.getProperty("keyAlias")
            keyPassword = signingProperties.getProperty("keyPassword")
            storePassword = signingProperties.getProperty("storePassword")
            storeFile = signingProperties.getProperty("storeFile")?.let {
                rootProject.file(it)
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
