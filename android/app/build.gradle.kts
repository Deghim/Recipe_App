import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}


android {
    namespace = "com.recipebookdemo.recipe_book"
    // compileSdk = flutter.compileSdkVersion
    compileSdk = 34
    // ndkVersion = flutter.ndkVersion
    // ndkVersion = "21.3.6"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.recipebookdemo.recipe_book"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // minSdk = flutter.minSdkVersion
        minSdk = 21
        // targetSdk = flutter.targetSdkVersion
        targetSdk = 34
        // versionCode = flutter.versionCode
        versionCode = 2
        // versionName = flutter.versionName
        versionName = "1.1"
    }

    signingConfigs {
        create("release") {
            // keyAlias = keystoreProperties["keyAlias"] as String
            // keyPassword = keystoreProperties["keyPassword"] as String
            // storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            // storePassword = keystoreProperties["storePassword"] as String
            
            keyAlias = requireNotNull(keystoreProperties.getProperty("keyAlias")) { "keyAlias missing in key.properties" }
            keyPassword = requireNotNull(keystoreProperties.getProperty("keyPassword")) { "keyPassword missing in key.properties" }
            storeFile = file(requireNotNull(keystoreProperties.getProperty("storeFile")) { "storeFile missing in key.properties" })
            storePassword = requireNotNull(keystoreProperties.getProperty("storePassword")) { "storePassword missing in key.properties" }

        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled  = true
            isShrinkResources  = true
             proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
dependencies {
    implementation("com.github.bumptech.glide:glide:4.12.0")
    annotationProcessor("com.github.bumptech.glide:compiler:4.12.0")
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.okhttp3:okhttp:4.9.0")
}

flutter {
    source = "../.."
}
