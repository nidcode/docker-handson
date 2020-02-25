# docker-handson
## はじめに
- このリポジトリはJBグループ社内向けのdockerハンズオン環境構築用リポジトリです
- [Terraform](https://www.terraform.io/docs/index.html)で記述しています(v0.12以降)
- 環境を構築する人は、ある程度Terraformの知識がある前提です。

## 説明
#### 以下のリソースが実行したAWSアカウント上で作成されます。
- VPC
- Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance

## 前提
- terraform（v0.12以降）がインストールされている事
- ~/.aws/credentialが適切に設定されている事

#### 推奨
- aws cliがインストールされている事

## 設定
#### tfstate保存先の設定
- [terraform/default.tf](./terraform/default.tf)を見てください
- 特に、`terraform.backend.s3`の**bucket**,**key**には注意が必要です。

#### リソースの設定
- [terraform/variables.tf](./terraform/variables.tf)を見てください
- 特に、vpcのcidr、subnetのcidr、インスタンスタイプ、usersを適切に設定してください。

## 使い方
- 初回
  -  `git clone <this_repo_url>`
  - `cd docker-handson/terraform`
  - `terraform init && terraform fmt`
- テスト
  - `terraform plan`
- 適用
  - `terraform apply`
