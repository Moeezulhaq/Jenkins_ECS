def call () {

<<<<<<< HEAD
=======
//     sh "echo hello world"
//   post
//   {
>>>>>>> ba7ed15362fe88d2bd39cf58c1e43df164257ad0
    //   always
    //   {
        slackSend channel: 'moeez_testing', message: "Please Find status of Job status- ${currentBuild.currentResult} Build Name-${env.JOB_NAME} Build Number-${env.BUILD_NUMBER} Build URL-${env.BUILD_URL}"
    //   }
<<<<<<< HEAD
=======
//   }
>>>>>>> ba7ed15362fe88d2bd39cf58c1e43df164257ad0
}
