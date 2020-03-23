# build and deploy the site
param(
    [boolean] $Force
)
$pull_result = git pull upstream master
Write-Output $pull_result
if ($pull_result -ne "Already up to date." -or $Force){
    py .\coronavirus2019.py
    pageres 'https://covid19info.live/' 1180x1500 --selector='#statistics > div.map-container' --filename='content/covidinfo.live.png' --crop --overwrite
    # pageres 'https://covid19info.live/' 1180x1500 --selector='#statistics > div.map-container' --filename='content/covidinfo.live.png' --crop --overwrite
    hugo
    Set-Content -Path 'docs/CNAME' -Value 'stasis.global'
    git add .; git commit -m 'updates'; git push
}
