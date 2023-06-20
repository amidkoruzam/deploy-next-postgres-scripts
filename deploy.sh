directory_name=/app/$(date +'%Y_%m_%d_%H%M')

scp -r --exclude=node_modules . user@remote-server:$directory_name

cd $directory_name
mv .env.prod .env
npm ci
npm run build

pm2 stop app
pm2 start npm --name "app" -- start

$total=$(($(ls | wc -l)))
$count_to_delete=$(expr $total - 5)

if [ $count_to_delete -gt 0 ]
then
    ls | head -n $count_to_delete | xargs rm -rf
fi
