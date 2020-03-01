# build and deploy the site
git pull upstream master
py .\coronavirus2019.py
hugo
Set-Content -Path 'docs/CNAME' -Value 'http://statis.global'
git add .; git commit -m 'updates'; git push
