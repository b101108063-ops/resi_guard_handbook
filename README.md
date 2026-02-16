# resi_guard

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

flutter build web --release --base-href "/resi_guard_handbook/"

if (Test-Path docs) { Remove-Item -Recurse -Force docs }
New-Item -ItemType Directory -Force -Path docs
Copy-Item -Path "build\web\*" -Destination "docs" -Recurse -Force

git add .
git commit -m "Fix: Add missing UI for Ch24-Ch26"
git push