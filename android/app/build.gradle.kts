import java.io.FileInputStream
import java.util.Properties

// O bloco de carregamento do key.properties em Kotlin DSL
val keystoreProperties = Properties()
val keystoreFile = rootProject.file("../key.properties")
if (keystoreFile.exists()) {
    keystoreProperties.load(FileInputStream(keystoreFile))
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "br.edu.unisagrado.burnquest"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "br.edu.unisagrado.burnquest"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
         create("release") {
            // Adicione estas linhas para depuração temporária
            println("Debug: key.properties path exists? ${keystoreFile.exists()}")
            if (keystoreFile.exists()) {
                println("Debug: Properties loaded. Keys available: ${keystoreProperties.stringPropertyNames()}")
            }
            println("Debug: storeFile = ${keystoreProperties["storeFile"]}")
            println("Debug: keyAlias = ${keystoreProperties["keyAlias"]}")
            // Fim das linhas de depuração

            if (keystoreProperties.containsKey("keyAlias")) {
                keyAlias = keystoreProperties["keyAlias"] as String
            } else {
                println("Error: keyAlias not found in key.properties!")
            }
            if (keystoreProperties.containsKey("keyPassword")) {
                keyPassword = keystoreProperties["keyPassword"] as String
            } else {
                println("Error: keyPassword not found in key.properties!")
            }
            if (keystoreProperties.containsKey("storeFile")) {
                storeFile = file(keystoreProperties["storeFile"] as String)
            } else {
                println("Error: storeFile not found in key.properties!")
            }
            if (keystoreProperties.containsKey("storePassword")) {
                storePassword = keystoreProperties["storePassword"] as String
            } else {
                println("Error: storePassword not found in key.properties!")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release") // Use getByName para referenciar a configuração de release
        }
    }
}

flutter {
    source = "../.."
}
