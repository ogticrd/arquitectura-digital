This is a new [**Flutter**](https://flutter.dev/) project with a basic Oauth implemented

# Getting Started

>**Note**: Make sure you have [Flutter correctly installed](https://docs.flutter.dev/get-started/install) before trying this trying this tutorial

## Setting up the needed permissions

This is an overview of the permissions that are needed for the Oauth process to work. Everything in this section is already done in the example and it is here in case someone wants to implemented in an already developed flutter application

### Modidy iOs configuration

- Open your project's Info.plist file.

- Add a new key called "CFBundle URLTypes" of type Array.

- Add a ner item under "CFBundleURLTypes" and set the URL Scheme (CFBundleURLSchemes) to desired scheme, e.g., "myapp"

- Save the cahnges

```
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>myapp</string> <!-- Replace "myapp" with your desired scheme -->
    </array>
  </dict>
</array>
```

### Configure the Android manifest (AndroidManifest.xml)

- Open the `AndroidManifest.xml` file located in the `android/app/src/main` directory.

- Add an intent filter within the `<activity>` tag.

- Set the `android:scheme` attribute to your desired scheme, e.g., "myapp".

- Save the changes.

```
<activity>
  ...
  <intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data
        android:scheme="myapp" /> <!-- Replace "myapp" with your desired scheme -->
  </intent-filter>
</activity>
```

## Starting the Application

After installing the package dependencies with 


```
flutter pub get
```

run the application

```
flutter run
```

# Troubleshooting

If you can't get this to work, see the [Common Flutter errors](https://docs.flutter.dev/testing/common-errors) page.

# Learn More

To learn more about Flutter, take a look at the following resources:

- [Flutter Website](https://flutter.dev/) - learn more about Flutter.
- [Getting Started](https://docs.flutter.dev/get-started/install) - an **overview** of Flutter and how setup your environment.
- [`@flutter/flutter`](https://github.com/flutter/flutter) - the Open Source; GitHub **repository** for Flutter.
