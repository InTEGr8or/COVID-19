# build and deploy the site
git pull origin upstream master
hugo
py .\coronavirus2019.py
git add .
git commit -m 'updates'
git push
