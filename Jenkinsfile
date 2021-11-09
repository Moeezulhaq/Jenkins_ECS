pipeline {
  agent any
  parameters {
    choice(
      name: 'ACTION',
      choices: ['create-cluster', 'update-cluster', 'delete-cluster'],
      description: 'CloudFormation Actions'
    )
    choice(
      name: 'VPC',
      choices: ['deploy-stack', 'update-stack', 'delete-stack'],
      description: 'CloudFormation Actions'
    )    
    string(name: 'STACK_NAME', defaultValue: 'example-stack', description: 'Enter the CloudFormation Stack Name.')
    string(name: 'PARAMETERS_FILE_NAME', defaultValue: 'parameters/example-stack-parameters.properties', description: 'Enter the Parameters File Name (Must contain file extension type *.properties)')
    string(name: 'TEMPLATE_NAME', defaultValue: 'Word.yml', description: 'Enter the CloudFormation Template Name (Must contain file extension type *.yaml)')
    string(name: 'CIDR', defaultValue: '10.0.0.0/16', description: 'Enter the CIDR for CloudFormation Template ')
    string(name: 'PUBLIC_SUBNET', defaultValue: '10.0.1.0/24', description: 'Enter the CIDR for CloudFormation Template public subnet')
    string(name: 'PRIVATE_SUBNET', defaultValue: '10.0.2.0/24', description: 'Enter the CIDR for CloudFormation Template private subnet')
    credentials(name: 'CFN_CREDENTIALS_ID', defaultValue: '', description: 'AWS Account Role.', required: true)
    choice(
      name: 'REGION',
      choices: ['us-east-1','us-east-2'],
      description: 'AWS Account Region'
    )
  }

  stages { 
        stage('deploy-stack') {
        when {
            expression { params.VPC == 'deploy-stack' }
        }
        steps {
        sh "aws cloudformation create-stack --stack-name ${STACK_NAME} --template-body file://${TEMPLATE_NAME} --region ${REGION} --parameters ParameterKey=MyCIDR,ParameterValue=${CIDR} ParameterKey=publicsubnetcidr,ParameterValue=${PUBLIC_SUBNET} ParameterKey=privatesubnetcidr,ParameterValue=${PRIVATE_SUBNET}"
        }
    }

        stage('update-stack') {
        when {
            expression { params.VPC == 'update-stack' }
        }
        steps {
        sh "aws cloudformation update-stack --stack-name ${STACK_NAME} --template-body file://${TEMPLATE_NAME} --region ${REGION} --parameters ParameterKey=MyCIDR,ParameterValue=${CIDR} ParameterKey=publicsubnetcidr,ParameterValue=${PUBLIC_SUBNET} ParameterKey=privatesubnetcidr,ParameterValue=${PRIVATE_SUBNET}"    
        }
    }

        stage('delete-stack') {
        when {
            expression { params.VPC == 'delete-stack' }
        }
        steps {
        sh "aws cloudformation delete-stack --stack-name ${STACK_NAME} --region ${REGION}"    
        }
    }    
        stage('Login to ECR') {

        steps {
        sh "aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/y2a9o9h4"
        }
    }

        stage('Build Image') {

        steps {
        sh "docker build -t jenkins-ecs ."    
        }
    }

        stage('Tag Image') {

        steps {
        sh "docker tag jenkins-ecs:latest public.ecr.aws/y2a9o9h4/jenkins-ecs:latest"    
        }
    }

        stage('Push Image') {

        steps {
        sh "docker push public.ecr.aws/y2a9o9h4/jenkins-ecs:latest"    
        }
    }
        stage('Task-definition') {

        steps {
        sh "aws ecs register-task-definition --cli-input-json file://taskdef.json --region us-east-1"    
        }
    }    
  
        stage('create-cluster') {
        when {
            expression { params.ACTION == 'create-cluster' }
        }
        steps {
        sh "aws ecs create-cluster --cluster-name mycluster --region us-east-1"    
        }
    }    
    
        stage('delete-cluster') {
        when {
            expression { params.ACTION == 'delete-cluster' }
        }
        steps {
        sh "aws ecs delete-cluster --cluster mycluster --region us-east-1"    
        }
    }


    // //     stage('create-service') {

    // //     steps {
    // //     sh "aws ecs create-service --cluster mycluster --service-name MyService --desired-count 2 --cli-input-json file://service.defination.json --region us-east-1"    
    // //     }
    // // }

    // //     stage('Create-task-set') {

    // //     steps {
    // //     sh "aws ecs create-task-set --cluster mycluster --service MyService --task-definition sample-fargate:11 --network-configuration awsvpcConfiguration={subnets=[subnet-0b48f8acbc06080d4],securityGroups=[sg-0541867ccac96203a],assignPublicIp=ENABLED} --cli-input-json file://TaskSet.template.json --region us-east-1"    
    // //     }
    // // }
    //     stage('task-set') {

    //     steps {
    //     sh "aws ecs run-task --cluster mycluster --task-definition sample-fargate:11 --network-configuration awsvpcConfiguration={subnets=[subnet-0b48f8acbc06080d4],securityGroups=[sg-0541867ccac96203a]} --region us-east-1"    
    //     }
    // }
  
  }
}
//   post
//   {
//       always
//       {
//         slackSend channel: 'moeez_testing', message: "Please Find status of Job status- ${currentBuild.currentResult} Build Name-${env.JOB_NAME} Build Number-${env.BUILD_NUMBER} Build URL-${env.BUILD_URL}"
//       }
//   }
// }