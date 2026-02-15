import java.util.*

// Top-level build file where you can add configuration options common to all sub-projects/modules.

val properties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { properties.load(it) }
}

val flutterSdkPath = properties.getProperty("flutter.sdk")
buildscript {
    repositories {
        google()
        mavenCentral()
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}


plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.rhamadhany.xml2axml_flutter"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }


    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("main").java.srcDirs("xml2axml/src/main/java")
        getByName("test").java.srcDirs("src/test/kotlin")
    }

    defaultConfig {
        minSdk = 21
    }


    dependencies {
        testImplementation("org.jetbrains.kotlin:kotlin-test")
        testImplementation("org.mockito:mockito-core:5.0.0")
        compileOnly(files("$flutterSdkPath/bin/cache/artifacts/engine/android-arm64/flutter.jar"))
//        implementation(project(":xml2axml"))
        implementation("commons-io:commons-io:2.21.0")
        implementation("net.sf.kxml:kxml2:2.3.0")
        implementation("org.apache.commons:commons-lang3:3.20.0")

    }
}
