# build and deploy the site
param(
    [boolean] $Force
)
$pull_result = git pull upstream master
Write-Output $pull_result
if ($pull_result -ne "Already up to date." -or $Force){
    py .\coronavirus2019.py
    # py .\grab_screens.py
    pageres 'https://covid19info.live/' 900x1000 --selector='#statistics > div.col-2 > div:nth-child(2)' --filename='content/covidinfo.live' --crop --overwrite
    pageres 'https://www.worldometers.info/coronavirus/' 900x300 --selector='body > div.container > div:nth-child(2) > div.col-md-8 > div > div:nth-child(16)' --filename='content/worldometers_coronavirus' --crop --overwrite
    # pageres 'https://covid19info.live/' 1180x1500 --selector='#statistics > div.map-container' --filename='content/covidinfo.live.png' --crop --overwrite
    # py .\image_resize.py 'content/covid.live.png'
    # py .\image_resize.py 'content/worldometers_coronavirus.png'
    hugo
    Set-Content -Path 'docs/CNAME' -Value 'stasis.global'
    git add .; git commit -m 'updates'; git push
}



