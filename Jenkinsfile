pipeline {
  agent any
  parameters {
    choice(
      name: 'ACTION',
      choices: ['deploy-cluster', 'delete-cluster'],
      description: 'CloudFormation Actions'
    )
    string(name: 'STACK_NAME', defaultValue: 'testing', description: 'Enter the CloudFormation Stack Name.')
  }

  stages { 
        stage('Building & tagging Image') {

        steps {
        sh "./Tag.sh"  
        }
    }
        stage('Deploying on ecs') {
        when {
            expression { params.ACTION == 'deploy-cluster' }
        }
        steps {
        sh "aws cloudformation deploy --template-file ecs.yml --stack-name ${STACK_NAME} --region us-east-1"    
        }
    }
        stage('Delete cluster') {
        when {
            expression { params.ACTION == 'delete-cluster' }
        }
        steps {
        sh "aws cloudformation delete-stack --stack-name ${STACK_NAME} --region us-east-1"    
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

