import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.hropal.app.dev"
            resValue(type = "string", name = "app_name", value = "[Dev] HR Opal")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "com.hropal.app.staging"
            resValue(type = "string", name = "app_name", value = "[Staging] HR Opal")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.hropal.app"
            resValue(type = "string", name = "app_name", value = "HR Opal")
        }
    }

    buildFeatures.resValues = true
}