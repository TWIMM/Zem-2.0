/* groovylint-disable-next-line CompileStatic */
    def sendNotification(color,message,channel) {
        mattermostSend(
            color: color,
            // username: "jenkins_gitlab",
            channel: channel,
            icon: "https://blog.cloud-partner.jp/wp-content/uploads/2022/08/gitlab_icon_130930.png",
            endpoint: "https://mattermost.geminico.cloud/hooks/mqu5q3tuhbnfzf3adsf74kdrbo",
            message: message
        )
    }
node {
    /* groovylint-disable-next-line NoDef, VariableTypeRequired */

    try {
        sendNotification('#2A42EE', "Build STARTED: ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Link to build>)","apk-release")
        stage('Clone Repo') {
            sendNotification('#fc5a03', "Clone Repo: ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Link to build>)","apk-release")
            git branch: 'develop',
            credentialsId: '974bb4d4-016a-4f05-82a9-ea55e365055b',
            poll: false,
            url: 'git@gitlab.geminico.cloud:agrimarket/flutter-app.git'
        }
        stage('Build and Compile with docker') {
            // sh 'cp .env.development .env'
            sendNotification('#1a527d', "Build and Compile with docker : ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Link to build>)","apk-release")
            try {
                dockerImage = docker.build('agrimarket-project/flutter-dev-app')
            }catch (e) {
                currentBuild.result = 'FAILED'
                // sendNotification('#1a527d', "Build docker failed with error : ${currentBuild.result} ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Link to build>)")
            }
            // dockerImage = docker.build('agrimarket-project/flutter-dev-app')
            //docker cp CONTAINER_ID:/app/build/app/outputs/flutter-apk/app-release.apk .
            //docker cp CONTAINER_ID:/app/unique_name.txt .
            //\
    //mv build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/app-$(date +%Y%m%d%H%M%S).apk

        }
        stage('Compile app with docker') {
            sendNotification('#7d1a71', "Run docker image and mount app folder: ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Link to build>)","apk-release")

            sh 'docker stop flutter-dev-app || true && docker rm flutter-dev-app || true'
            sh 'docker run --name flutter-dev-app -d agrimarket-project/flutter-dev-app'
            //The volume is not necessary -v /opt/buildapkvolume:/app
            sh "docker cp flutter-dev-app:/app/build/app/outputs/flutter-apk/app-release.apk /opt/apkstorage/agrimarket-project/app-release-${env.BUILD_ID}.apk"
        }
    } catch (e) {
        currentBuild.result = 'FAILED'
        throw e
    } finally {
        if (currentBuild.result != 'FAILURE') {
            sendNotification('good', "Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Link to build>)","apk-release")
            final String currentTime = sh(returnStdout: true, script: 'date +%Y-%m-%d').trim()
            sendNotification('good', "New Apk Release at ${currentTime} : (<https://storage.geminico.cloud/agrimarket-project/app-release-${env.BUILD_ID}.apk | Click to download>)","apk-release")
        }else{
            sendNotification('danger', "Build FAILED:  ${env.JOB_NAME} #${env.BUILD_NUMBER} (<${env.BUILD_URL}|Link to build>)","apk-release")
        }
    }
}
