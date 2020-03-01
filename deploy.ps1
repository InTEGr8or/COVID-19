# build and deploy the site
param(
    [boolean] $Force
)
$pull_result = git pull upstream master
echo $pull_result
if ($pull_result -ne "Already up to date." -or $Force){
    py .\coronavirus2019.py
    hugo
    Set-Content -Path 'docs/CNAME' -Value 'stasis.global'
    git add .; git commit -m 'updates'; git push
}
