pipeline {
  agent any
  parameters {
    choice(
      name: 'ACTION',
      choices: ['create-cluster', 'update-cluster', 'delete-cluster'],
      description: 'CloudFormation Actions'
    )
//     string(name: 'STACK_NAME', defaultValue: 'example-stack', description: 'Enter the CloudFormation Stack Name.')
//     string(name: 'PARAMETERS_FILE_NAME', defaultValue: 'parameters/example-stack-parameters.properties', description: 'Enter the Parameters File Name (Must contain file extension type *.properties)')
//     string(name: 'TEMPLATE_NAME', defaultValue: 'Word.yml', description: 'Enter the CloudFormation Template Name (Must contain file extension type *.yaml)')
//     string(name: 'CIDR', defaultValue: '10.0.0.0/16', description: 'Enter the CIDR for CloudFormation Template ')
//     string(name: 'PUBLIC_SUBNET', defaultValue: '10.0.1.0/24', description: 'Enter the CIDR for CloudFormation Template public subnet')
//     string(name: 'PRIVATE_SUBNET', defaultValue: '10.0.2.0/24', description: 'Enter the CIDR for CloudFormation Template private subnet')
//     credentials(name: 'CFN_CREDENTIALS_ID', defaultValue: '', description: 'AWS Account Role.', required: true)
//     choice(
//       name: 'REGION',
//       choices: ['us-east-1','us-east-2'],
//       description: 'AWS Account Region'
//     )
  }

  stages { 

        stage('Login to ECR') {

        steps {
        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 489994096722.dkr.ecr.us-east-1.amazonaws.com"
        }
    }

        stage('Build Image') {

        steps {
        sh "docker build -t testingmoeez ."    
        }
    }

        stage('Tag Image') {

        steps {
        sh "docker tag testingmoeez:latest 489994096722.dkr.ecr.us-east-1.amazonaws.com/testingmoeez:latest"    
        }
    }

        stage('Push Image') {

        steps {
        sh "docker push 489994096722.dkr.ecr.us-east-1.amazonaws.com/testingmoeez:latest"    
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


        stage('run-task') {

        steps {
        sh "aws ecs run-task --cluster mycluster --task-definition sample-fargate:11 --count 11 --region us-east-1"    
        }
    }

    //     stage('Create-task-set') {

    //     steps {
    //     sh "aws ecs create-task-set --cluster mycluster --cli-input-json file://create-service.json --region us-east-1"    
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