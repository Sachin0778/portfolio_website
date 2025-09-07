#!/bin/bash

# Portfolio Website Deployment Script for GitHub Pages

echo "🚀 Starting deployment process..."

# Build the Flutter web app
echo "📦 Building Flutter web app..."
flutter build web

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    # Copy build files to docs folder (GitHub Pages requirement)
    echo "📁 Copying build files to docs folder..."
    rm -rf docs
    mkdir docs
    cp -r build/web/* docs/
    
    # Create a simple index.html redirect if needed
    echo "📝 Creating deployment files..."
    
    echo "🎉 Deployment files ready!"
    echo ""
    echo "Next steps:"
    echo "1. Commit and push your changes:"
    echo "   git add ."
    echo "   git commit -m 'Deploy portfolio website'"
    echo "   git push origin main"
    echo ""
    echo "2. Enable GitHub Pages in your repository settings:"
    echo "   - Go to Settings > Pages"
    echo "   - Source: Deploy from a branch"
    echo "   - Branch: main / docs"
    echo ""
    echo "3. Your portfolio will be available at:"
    echo "   https://yourusername.github.io/portfolio_website"
    
else
    echo "❌ Build failed! Please check the errors above."
    exit 1
fi
