## 説明

package.jsonなどで定義しているコマンドをタブ補完します

## セットアップ

#### linux

- yumでjqとbash-completionをインストール


```bash
yum -y install jq bash-completion
```
   
- .bash_profileを修正

### windows

- chocolateyでjqをインストール

```powershell
choco install jq
```

- .bash_profileを修正

## 使い方

package.jsonに以下のような定義をした場合

```json
{
  "scripts": {
    "test": "jest -v & jest",
    "lint": "eslint -V & eslint",
    "gulp": "gulp",
    "hello": "echo hello"
  }
}
```

package.jsonより下位のディレクトリで

`yum <tab>`とすると`test lint gulp hello`がタブ補完できます


## サポート範囲

|コマンド|チェックするファイル|事前コマンド|補完対象|補完位置|
|:-|:-|:-|:-|:-|
|npm|package.json||scripts|npm run-script \<tab\><br>npm run \<tab\>|
|yarn|package.json||scripts|yarn run \<tab\><br>yarn \<tab\>|
|composer|composer.json||scripts|composer \<tab\>||
|pipenv|Pipfile||scripts|pipenv run \<tab\>|
|gulp|gulpfile.js|$ setTask gulp|gulpで登録しているタスク|gulp run \<tab\><br>yarn gulp\<tab\><br>npm run gulp \<tab\>|
