pipeline {
  agent any
  parameters {
    choice(
      name: 'ACTION',
      choices: ['deploy-cluster', 'delete-cluster'],
      description: 'CloudFormation Actions'
    )

//     // string(name: 'STACK_NAME', defaultValue: 'example-stack', description: 'Enter the CloudFormation Stack Name.')
//     // string(name: 'PARAMETERS_FILE_NAME', defaultValue: 'parameters/example-stack-parameters.properties', description: 'Enter the Parameters File Name (Must contain file extension type *.properties)')
//     // string(name: 'TEMPLATE_NAME', defaultValue: 'Word.yml', description: 'Enter the CloudFormation Template Name (Must contain file extension type *.yaml)')
//     // string(name: 'CIDR', defaultValue: '10.0.0.0/16', description: 'Enter the CIDR for CloudFormation Template ')
//     // string(name: 'PUBLIC_SUBNET', defaultValue: '10.0.1.0/24', description: 'Enter the CIDR for CloudFormation Template public subnet')
//     // string(name: 'PRIVATE_SUBNET', defaultValue: '10.0.2.0/24', description: 'Enter the CIDR for CloudFormation Template private subnet')
//     // credentials(name: 'CFN_CREDENTIALS_ID', defaultValue: '', description: 'AWS Account Role.', required: true)
//     // choice(
//     //   name: 'REGION',
//     //   choices: ['us-east-1','us-east-2'],
//     //   description: 'AWS Account Region'
//     // )
  }

  stages { 

        stage('Building & tagging Image') {

        steps {
        sh "./Tag.sh"  
        }
    }

        stage('Tag Image') {

        steps {
        sh"./Tag.sh"  
        }
    }
       
        stage('Deploying on ecs') {
        when {
            expression { params.ACTION == 'deploy-cluster' }
        }
        steps {
        sh "aws cloudformation deploy --template-file ecs.yml --stack-name ecs"    
        }
    }

        stage('Delete cluster') {
        when {
            expression { params.ACTION == 'delete-cluster' }
        }
        steps {
        sh "aws cloudformation delete-stack --stack-name ecs"    
        }
    }
  }

  post
  {
      always
      {
        slackSend channel: 'moeez_testing', message: "Please Find status of Job status- ${currentBuild.currentResult} Build Name-${env.JOB_NAME} Build Number-${env.BUILD_NUMBER} Build URL-${env.BUILD_URL}"
      }
  }
}