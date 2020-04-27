#!/bin/bash

clear

echo "Welcome to INVNTRI"
echo ""
echo "----------------------------------------"
echo ""

echo "Lets begin the Gem install now"
echo "Installing Bundler"
gem install bundler

echo "Ensuring all required gems are installed"
bundle install

echo ""
echo "All gems have been installed"
echo ""
echo "----------------------------------------"
echo ""

echo "Before we start, what's your name?"

read -p "=> " name
echo ""
read -p "Thanks, launch INVNTRI? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

echo ""
echo "Running application for the first time now"
echo ""
echo "----------------------------------------"

sleep 1

ruby invntri.rb $name