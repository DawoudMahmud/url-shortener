# QuickLink
## Technologies used: AWS API Gateway, DynamoDB, and Lambda functions

### Prerequisites
* Required software installed on your local environment:
  * [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
    * **Note**:  Mac users can use [tfenv](https://github.com/tfutils/tfenv) for terraform management.
  * [Golang](https://go.dev/doc/install)
* An active AWS Account
* An already purchased domain name that you will use for your "short url" . 
* Configure your AWS credentials locally [as recommended](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
in `$HOME/.aws/credentials`

### Installation
1. Clone this repository and navigate to the project root:
```bash
git clone git@github.com:dawoudmahmud/url-shortener.git
cd url-shortener
```
2. From the project root directory, create all AWS resources through `terraform`:
```bash
# Run a `terraform plan` first to preview changes
terraform plan

# Apply the changes if there are no concerns
terraform apply
```

### Deploying updates to lambda functions
For updates in `./lambdas/shorten/main.go` and/or `./lambdas/redirect/main.go`
execute the following command from the root directory:
```bash
./update_lambdas.sh
```
The script builds new binaries and compresses them. Upon pressing ENTER, it performs a `terraform apply`.

### Usage

#### Create a Custom 'short' URL
To create a shortened url with a custom slug, run the command below from any machine:
```
curl -X POST \
  'https://yourdomain.com/shorten' \
  --header 'Content-Type: application/json' \
  --data-raw '{"url": "https://example.com/long-url-to-short", "slug":"custom-slug"}'
```

#### Create a Random 'short' URL 
To create a shortened url, run the command below from any machine:
```
curl -X POST \
  'https://yourdomain.com/shorten' \
  --header 'Content-Type: application/json' \
  --data-raw '{"url": "https://example.com/long-url-to-short"}'
```

Example response:
```
https://yourdomain.com/cdff2
```

#### How to use the shortened URL
Copy/paste the shortened URL (e.g. `https://yourdomain.com/cdff2`) in a browser and see what happens
