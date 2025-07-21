#!/usr/bin/env bash

# Node.js setup
if [ -f package.json ]; then
  bash -i -c "nvm install --lts && nvm install-latest-npm"
  npm i
  npm run build
fi

# Jekyll/Ruby setup
echo "Setting up Jekyll environment..."

# Install Ruby dependencies
if [ -f Gemfile ]; then
  echo "Installing Ruby gems..."
  bundle install
fi

# Chirpy theme specific setup
if [ -f tools/init.sh ]; then
  echo "Initializing Chirpy theme..."
  bash tools/init.sh
fi

# Create npm scripts if package.json exists but doesn't have dev script
if [ -f package.json ]; then
  # Check if dev script doesn't exist
  if ! grep -q '"dev"' package.json; then
    echo "Adding Jekyll dev script to package.json..."
    # Create a temporary file with the updated package.json
    jq '.scripts.dev = "bundle exec jekyll serve --host 0.0.0.0 --livereload --force_polling"' package.json > package.json.tmp && mv package.json.tmp package.json
  fi
fi

# Install dependencies for shfmt extension
curl -sS https://webi.sh/shfmt | sh &>/dev/null

# Add OMZ plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 2>/dev/null || true
sed -i -E "s/^(plugins=\()(git)(\))/\1\2 zsh-syntax-highlighting zsh-autosuggestions\3/" ~/.zshrc

# Avoid git log use less
echo -e "\nunset LESS" >>~/.zshrc

# Add helpful aliases for Jekyll development
echo -e "\n# Jekyll aliases" >>~/.zshrc
echo "alias jdev='bundle exec jekyll serve --host 0.0.0.0 --livereload --force_polling'" >>~/.zshrc
echo "alias jbuild='bundle exec jekyll build'" >>~/.zshrc
echo "alias jclean='bundle exec jekyll clean'" >>~/.zshrc

echo "Post-create setup completed!"
echo "You can start Jekyll with: bundle exec jekyll serve --host 0.0.0.0 --livereload --force_polling"
echo "Or use the alias: jdev"
