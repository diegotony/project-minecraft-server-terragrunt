# Minecraft Server
## Dependencies
- Docker
- AWS Credentials

## Instructions
```bash
# You need set your AWS credentials in .env file, for more informaction check **.env.template**
bash server.sh init
bash server.sh plan
bash server.sh apply

# In case the destroy the resources
bash server.sh destroy

# In case the clean Env the resources
bash server.sh clean
```

## Resources
- https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway

- https://dev.to/julbrs/how-to-run-a-minecraft-server-on-aws-for-less-than-3-us-a-month-409p

- https://stackoverflow.com/questions/35895315/use-terraform-to-set-up-a-lambda-function-triggered-by-a-scheduled-event-source

## TO DO
- Draw architecture
- Operating scheme