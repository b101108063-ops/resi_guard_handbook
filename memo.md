# 1. 清理舊的編譯檔
flutter clean
flutter pub get

# 2. 編譯網頁 (請確認倉庫名稱是 resi_guard_handbook)
flutter build web --release --base-href "/resi_guard_handbook/"

# 3. 更新 docs 資料夾 (刪除舊的 -> 建立新的 -> 複製檔案)
if (Test-Path docs) { Remove-Item -Recurse -Force docs }
New-Item -ItemType Directory -Force -Path docs
Copy-Item -Path "build\web\*" -Destination "docs" -Recurse -Force

git add .
git commit -m "Update: Add Ch26 Inguinal Hernia & Fix UI"
git push