# 万葉課題

root は　tasks#index　に設定してあります。
## Deploy手順
1. heroku login
1. heroku create アプリ名
1. git add .
1. git commit -m 'xxxxx'
1. git push heroku master
1. heroku run rails db:migrate
1. heroku open
> 注意点
> precompiling assets failed対策
> $ rails assets:precompile RAILS_ENV=production
> gitignore ファイルの編集 /public/assets　を消す。

## model Schema （予想）

| Model    | FK-1     | FK-2     | column1  | column2  | column3  |
| -------- | -------- | -------- | -------- | -------- | -------- |
| User     | -------- | -------- | name     | email    | password |
| Task     | user_id  | -------- | title    | content  | -------- |
| t_and_l  | task_id  | label_id | -------- | -------- | -------- |
| Label    | -------- | -------- | limit    | status   | priority |
| Limit    | -------- | -------- | content  | -------- | -------- |
| Status   | -------- | -------- | content  | -------- | -------- |
| Priority | -------- | -------- | content  | -------- | -------- |