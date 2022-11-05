pipeline{
    agent {
        label "master"
    }

    stages{
        stage("拉代码"){
            steps {
                sh "mkdir -p mall-api"
                dir("mall-api"){
                    checkout(
                        [
                            $class: "GitSCM",
                            branches: [[name: "master"]],
                            extensions: [[$class: "CleanBeforeCheckout"]],
                            userRemoteConfigs: [[url: "git@gitee.com:11547299/newbee-mall-api.git"]]
                        ]
                    )
                }
            }
        }

        stage("构建+发布"){
            steps{
                sh '''
                    cd mall-api
                    sh deploy_docker.sh
                '''
            }
        }
    }

    post {
        always {
            emailext body: '$DEFAULT_CONTENT', recipientProviders: [[$class: 'RequesterRecipientProvider']], subject: '$DEFAULT_SUBJECT', to: '$DEFAULT_RECIPIENTS'
        }
    }
}