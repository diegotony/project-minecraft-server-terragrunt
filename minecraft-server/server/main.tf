data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}


module "security_group" {
  source      = "../../resources/aws/security/security_group"
  name        = "${var.project}-security-group"
  description = "Security Group to ${var.project}"
  tags        = merge(var.tg_common_tags, { "Name" = "${var.project}" })
}

module "server" {
  source          = "../../resources/aws/ec2"
  ami             = data.aws_ami.amazon.id
  instance_type   = "t2.small"
  security_groups = ["${module.security_group.name}"]
  key_name        = "EC2-INSTANCE"
  user_data       = <<EOF
    #! /bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello world  from $(hostname -f) </h1>" > /var/www/html/index.html
    sudo rpm --import https://yum.corretto.aws/corretto.key
    sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
    sudo yum install -y java-17-amazon-corretto-devel.x86_64
    java --version
    sudo adduser minecraft
    sudo su
    mkdir -p /opt/minecraft/server
    cd /opt/minecraft/server
    wget https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar
    sudo chown -R minecraft:minecraft /opt/minecraft/
    echo "eula=true" >> eula.txt
    echo "${file("${path.module}/src/config/minecraft.service")}" >> "/etc/systemd/system/minecraft.service"
    chmod 664 /etc/systemd/system/minecraft.service
    systemctl daemon-reload
    java -Xmx1024M -Xms1024M -jar /opt/minecraft/server/server.jar nogui
  EOF
  tags            = merge(var.tg_common_tags, { "Name" = "${var.project}" })
}

output "name" {
  value = "###############  PUBLIC IP ${module.server.public_ip}  ###############"
}

resource "random_pet" "lambda_bucket_name" {
  prefix = "${var.project_name}-functions"
  length = 4
}

module "bucket_functions" {
  source        = "../../resources/aws/storage/s3"
  bucket        = random_pet.lambda_bucket_name.id
  acl           = "private"
  force_destroy = true
}


output "test" {
  value = module.bucket_functions.id
}


module "lambda_mc_start" {
  source        = "../../resources/aws/lambda"
  source_dir    = "${path.module}/src/functions/mc_start"
  output_path   = "${path.module}/src/functions/mc_start.zip"
  function_name = "${var.project_name}-mc_start"
  bucket        = module.bucket_functions.id
  runtime       = "nodejs14.x"
  handler       = "index.handler"
  environment   = { INSTANCE_ID = module.server.id }
}

module "lambda_mc_shutdown" {
  source        = "../../resources/aws/lambda"
  source_dir    = "${path.module}/src/functions/mc_shutdown"
  output_path   = "${path.module}/src/functions/mc_shutdown.zip"
  function_name = "${var.project_name}-mc_shutdown"
  bucket        = module.bucket_functions.id
  runtime       = "nodejs14.x"
  handler       = "index.handler"
  environment   = { INSTANCE_ID = module.server.id, MAX_HOURS = "8" }
}

module "create_attact_policy" {
  source    = "../../resources/aws/identity/policy"
  actions   = ["ec2:*"]
  resources = ["arn:aws:ec2:*"]
  name      = "${var.project_name}-ec2FullAccess"
  role      = module.lambda_mc_shutdown.lambda_exec_name
}

module "cloudwatch_trigger_lambda" {
  source               = "../../resources/aws/events/lambda-cloudwatch-event"
  name                 = "every_20_minutes_${var.project_name}"
  description          = "Cloudwatch Event Trigger for ${var.project_name}"
  schedule_expression  = "rate(20 minutes)"
  lambda_function_arn  = module.lambda_mc_shutdown.lambda_arn
  lambda_function_name = module.lambda_mc_shutdown.lambda_function_name
}