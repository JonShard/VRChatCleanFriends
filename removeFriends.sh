#!/bin/bash
authCookie="authcookie_3c285f01-8d07-4819-b348-cf4e25091acb"
cutoffDate="2022-03-10T00:00:1.000Z" # Remove all friends who haven't logged in after this date.

apiKey="JlE5Jldo5Jibnk5O5hTx6XVqsJu4WJ26"

# Remove friends.txt if already exist
rm friends.txt &> /dev/null

# Testing credentials
echo "Testing credentials"
response=$(curl -s -w "%{http_code}\n" -o /dev/null --request GET --url "https://vrchat.com/api/1/auth/user?apiKey=$apiKey" --cookie "auth=$authCookie; Expires=null; Domain=vrchat.com")
if [ "$response" != "200" ]; then
    echo "Problem calling VRChat API. Response code: $response"
    exit 1
fi

userInfo=$(curl -s --request GET --url "https://vrchat.com/api/1/auth/user?apiKey=$apiKey" --cookie "auth=$authCookie; Expires=null; Domain=vrchat.com")
echo "Hello $(echo $userInfo | jq .displayName -r)"

# Gather friends' ids, username and last login date in fiends.txt. We ask for 100 at a time. Max 1000 friends.
echo "Fetching friends..."
for i in {1..10}; do
    curl -s -S --request GET --url "https://vrchat.com/api/1/auth/user/friends?offline=true&n=$(($i*100))&offset=0&apiKey=$apiKey" \
        --cookie "auth=$authCookie; Expires=null; Domain=vrchat.com" \
        | jq ".[] | {id, username,  last_login}" \
        | jq "select(.last_login < \"$cutoffDate\") | select(.username != null )" >> friends.txt
done

count=$(jq .username -r friends.txt | wc -l)
if [ "$count" == "0" ]; then
    echo "No friends to remove, all friends have been online after set cutoffDate: $cutoffDate"
    echo "Please edit the cutoffDate in this script to change how long frinds have to have been offline for in order to be removed."
    exit 2
fi

jq .username -r friends.txt
echo "Do you want to delete these friends? ($(jq .username -r friends.txt | wc -l))"
echo "If you're sure type 'yes' and hit enter"
read ready
if [[ $ready != "yes" ]]; then
    echo "Abort"
    exit 3
fi

# Send Delete request for each friend id in friends.txt
for friend in $(cat friends.txt | jq .id -r); do 
    curl --request DELETE --url "https://vrchat.com/api/1/auth/user/friends/$friend?apiKey=$apiKey" \
    --cookie "auth=$authCookie; Expires=null; Domain=vrchat.com" 
    echo
done
