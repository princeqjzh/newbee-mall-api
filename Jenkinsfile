pipeline{
    agent {
        label "test"
    }

    options {
        buildDiscarder(logRotator(daysToKeepStr: "180"))
    }

    parameters {
        string(name: "hostname", defaultValue: "localhost", description: "Running hostname")
        string(name: "api_branch", defaultValue: "master", description: "API project git branch")
        string(name: "vue_branch", defaultValue: "master", description: "VUE project git branch")
    }

    environment {
        hostname = "$params.hostname"
    }

    stages{
        stage("Pulling code"){
            parallel {
                stage("Pull API Code"){
                    steps {
                        sh "mkdir -p newbee-mall-api"
                        dir("newbee-mall-api"){
                            checkout(
                                [
                                    $class: "GitSCM",
                                    branches: [[name: "$params.api_branch"]],
                                    extensions: [[$class: "CleanBeforeCheckout"]],
                                    userRemoteConfigs: [[url: "https://github.com/princeqjzh/newbee-mall-api.git"]]
                                ]
                            )
                        }
                    }
                }

                stage("Pull VUE3 Code"){
                    steps {
                        sh "mkdir -p newbee-mall-vue3-app"
                        dir("newbee-mall-vue3-app"){
                            checkout(
                                [
                                    $class: "GitSCM",
                                    branches: [[name: "$params.vue_branch"]],
                                    extensions: [[$class: "CleanBeforeCheckout"]],
                                    userRemoteConfigs: [[url: "https://github.com/princeqjzh/newbee-mall-vue3-app.git"]]
                                ]
                            )
                        }
                    }
                }
            }
        }

        stage("Deploy"){
            parallel {
                stage("Deploy API"){
                    steps{
                        sh '''
                            cd newbee-mall-api
                            sh deploy_docker.sh
                        '''
                    }
                }

                stage("Deploy Web"){
                    steps{
                        sh '''
                            cd newbee-mall-vue3-app
                            sh docker_deploy.sh ${hostname}
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            emailext body: '$DEFAULT_CONTENT', recipientProviders: [[$class: 'RequesterRecipientProvider']], subject: '$DEFAULT_SUBJECT'
        }
    }
}