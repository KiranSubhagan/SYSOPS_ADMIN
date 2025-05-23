provider "aws" {
  region = "us-east-1"  # Change to your preferred AWS region
}



module "S3_Static_Site" {
  source = "./Modules/S3_Static_Site"
bucket_name = "mystatiakshayalfdgfhbsivshnfakshmicbucket234567123452678"

}
  
