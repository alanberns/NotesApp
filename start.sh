#!/bin/bash
cd frontend
vue serve &
cd ../backend
bundle install
rails db:migrate
rails server
    
#kill -9 $(sudo lsof -t -i:3000)
#kill -9 $(sudo lsof -t -i:8080)