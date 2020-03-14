# Below code is used to set backend only
s3_bucket                       	=	  "my-tf-test-bucket-tatiana"
s3_folder_region                	=	"us-east-1"
vpc_id		    	            	=	"vpc-0a03cd78b513f8932"
zone_id			                    =	"Z2C2TTKT34Z4V4" 
domain			                    =	"tatianamoraru.com"
base_domain			                =	"tatianamoraru.com"
region 			                    = 	"us-east-1"
s3_folder_project               	= "r1soft-project"  
instance_type                       = "t2.micro"
route_53                            = "tatianamoraru.com"
ssh_key_location                    =   "~/.ssh/id_rsa"
user                                = "ec2-user"
key_name                            = "test"
ami_id                              =   "ami-0fc61db8544a617ed"


# Please do not change below
environment                     	=   	"tower"
s3_folder_type                  	=   	"tools"
s3_tfstate_file                 	=   	"tower.tfstate"


