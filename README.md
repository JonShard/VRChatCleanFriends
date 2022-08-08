# VRChat Clean Friends
This is a shell script that removes friends from your account that have been inactive for longer than a set date. Default is 2021-01-01.

## Usage
**If you accidentally delete too many friends, don't delete any freinds_{date}.txt files**  
They can be used to recover friends.

### Get your credentials
In order for the script to manage your friends list on your behalf, you need to provide it with your credentials.
1. Log into https://vrchat.com
1. Open developer menu, F12 on firefox
1. Go to Networking tab
1. Refresh click a request that appeared in the list
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
Download the script run it using a shell terminal
You can download one by downloading git shell for windows at: https://gitforwindows.org/


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
```

## If you accidentally remove too many friends
*If you accidentally delete too many friends, don't delete any freinds_{date}.txt files**  
They can be used to recover friends.
