


cat forks.json | jq '.[].owner.login'

curl "https://api.github.com/repos/blockchain-audit/labs/forks?per_page=100" | jq '.[].full_name' | wc
