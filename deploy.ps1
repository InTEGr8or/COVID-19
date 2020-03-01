# build and deploy the site
git pull upstream master
py .\coronavirus2019.py
hugo
git add .
git commit -m 'updates'
git push
