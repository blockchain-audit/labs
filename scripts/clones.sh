#!/bin/bash

# List of GitHub users
users=(
    "rikiLuz"
    "MaayanShore"
    "saraovad"
    "tamarmara"
    "Tamar-Radin"
    "malka8580"
    "sari341"
    "PerryNusbaum"
    "chayaWolpin"
    "GiliSasportas"
    "ittyFish"
    "Sari2003"
    "hadasbeidani"
    "Riki3248"
    "ChanaIrinshtein"
    "323779108"
    "RacheliKm"
    "ruthklirs"
    "Chana-C"
    "peryGoldberg"
    "chayabres"
    "tova100"
    "MeiraYavetz"
    "MiriTenenboim"
    "rikiPraizler"
    "sariKahan"
    "HadasaHazan"
    "YaelTait"
    "chanaKastner"
    "shoshiGayer"
    "GittyBoim"
    "chana0"
    "elishevapro"
    "shaniBorek"
    "ShoshiSternberg"
    "RacheliPaley"
    "oritlu10"
    "YehudisSternberg"
)

# Loop through each user and clone their "labs" repository
for user in "${users[@]}"; do
    git clone "git@github.com:$user/labs.git" $user
done

