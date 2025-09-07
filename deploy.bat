@echo off
echo 🚀 Starting deployment process...

echo 📦 Building Flutter web app...
flutter build web

if %errorlevel% equ 0 (
    echo ✅ Build successful!
    
    echo 📁 Copying build files to docs folder...
    if exist docs rmdir /s /q docs
    mkdir docs
    xcopy /e /i build\web\* docs\
    
    echo 🎉 Deployment files ready!
    echo.
    echo Next steps:
    echo 1. Commit and push your changes:
    echo    git add .
    echo    git commit -m "Deploy portfolio website"
    echo    git push origin main
    echo.
    echo 2. Enable GitHub Pages in your repository settings:
    echo    - Go to Settings ^> Pages
    echo    - Source: Deploy from a branch
    echo    - Branch: main / docs
    echo.
    echo 3. Your portfolio will be available at:
    echo    https://yourusername.github.io/portfolio_website
) else (
    echo ❌ Build failed! Please check the errors above.
    exit /b 1
)

pause
