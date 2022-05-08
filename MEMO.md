■ やったこと

基本ソースコードは、https://github.com/NoriakiOtsuka/inari_online の
developブランチを利用しました。

次のA, B, Cの対応を行い、http://54.64.132.252/ で参照できるようにしています。
何回か、 bundle exec cap production deploy を実行してデプロイバージョンが反映されることを確認しました。Dは、サーバー上の整理目的でオマケ的にやってます。

A. 実行権限の付与
bundle exec cap production deploy を実行しても、サーバーが起動しない状態をなおしました。
原因は、bin/railsなどbin配下に実行権限がついてなかったことによります。
bin配下に、実行権限を付与する対応を行いました。

```
chmod +x bin/*
```

もともとは実行権限が付与されているものなのですが理由は不明です。


B. Gemfileとconfig/deploy.rbの修正

Gemfileの変更点

# gem 'capistrano-rails', group: :development

の行を次の内容に書き換えてます。追加後bundle installを実行してGemfile.lockを
更新してます。

gem 'capitrano-rails'
gem 'capistrano-rbenv'
gem 'capistrano3-puma's

config/deploy.rb の変更点

ブランチ指定を追加しました。
(こちらはよくわかってないですが、サーバー上のコードに書いてあったのでそのままです）

set :branch, 'develop'


C. /etc/nginx/conf.d/inari_online.conf の修正

capistranoがdeployすると /home/ec2-user/inari_online/current配下で起動します。
起動時には、ソケットファイルが/home/ec2-user/inari_online/current/tmp/sockets/puma.sockに作られます。nginxがこのソケットファイルを参照するように設定を変えました。

変更部分は下記

```
upstream puma {
    server unix:///home/ec2-user/inari_online/current/tmp/sockets/puma.sock;
}
```

D. サーバー上の不要なファイルの移動
Capistranoが作るファイル以外が、/home/ec2-user/inari_online 以下に混ざっていて混乱するので
次のファイルを残してそれ以外を /home/ec2-user/2022-05-08_inari_online 配下に移動しました。

- current
- releases
- repo
- revisions.log
- shared



