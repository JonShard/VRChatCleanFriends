# VRChat Clean Friends
This is a shell script that removes friends from your account that have been inactive for longer than a set date. Default is 2021-01-01.

## Usage
**If you accidentally delete too many friends, don't delete any freinds_{date}.txt files**  
They can be used to recover friends.

### Get your credentials
In order for the script to manage your friends list on your behalf, you need to provide it with your credentials.
1. Log into https://vrchat.com
1. Open developer menu, F12 on firefox
1. Go to Networking tab and Refresh the page
1. Click a request that appeared in the list
1. On the menu on the right, click Cookies
1. Look in the section Request Cookies
1. Copy the value of "auth" into authCookie variable in the script
1. Copy the value of "apiKey" into apiKey variable in the script

### Configure the script
This script has three configuration properties.
```shell
authCookie="authcookie_insert_your_credentials"
cutoffDate="2021-01-01T00:00:1.000Z" # Remove all friends who haven't logged in after this date

apiKey="JlE5Jldo5Jibnk5O5hTx6XVqsJu4WJ26"
```
authCookie - your authentication cookie that you found in the previous step.  
cutoffDate - UNIX format date defining how long a friends have to have been inactive for before it is removed.  
apiKey - VRChat API key. Haven't looked up what this does, but it is required.  

### Run the script
Download the script and run it using a shell terminal.  
You can download one by downloading git shell for windows at: https://gitforwindows.org/
Or you can set up WSL and effectifely run Ubuntu within windows: https://docs.microsoft.com/en-us/windows/wsl/install

You may need to add permissions to exexute the script:
```
chmod +x removeFriends.sh 
```

Run the script in the bash shell with:
```
./removeFriends.sh
```

Output:
```
Testing credentials
Hello JonShard
Fetching friends...
mybestfriend
yomama
coolestKid
Do you want to delete these friends? (3)
If you're sure type 'yes' and hit enter
yes
{"success":{"message":"Friendship destroyed","status_code":200}}
{"success":{"message":"Friendship destroyed","status_code":200}}
{"success":{"message":"Friendship destroyed","status_code":200}}
```

## If you accidentally remove too many friends
*If you accidentally delete too many friends, don't delete any freinds_{date}.txt files**  
They can be used to recover friends.
All the removed friends are stored in the friends file like:
friends_21:04:27.txt
```json
{
  "id": "usr_1a131e99-5221-4bbc-bfed-80428e489708",
  "username": "mybestfriend",
  "last_login": "2019-03-02T14:54:21.545Z"
}
{
  "id": "usr_81325b96-5078-487d-ba4a-ddf9a55f65bc",
  "username": "yomama",
  "last_login": "2020-02-27T14:16:42.201Z"
}
```
You can find any friend in this list by putting their user `id` in this url:  
https://vrchat.com/home/user/usr_81325b96-5078-487d-ba4a-ddf9a55f65bc  
Then you can send them a friends request to re-add you.
