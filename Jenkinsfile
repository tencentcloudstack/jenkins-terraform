pipeline {
    agent any
    tools {
        jfrog 'jfrog-cli'
    }
    environment {
        TEAM_NAME = get_team_name()
        TAR_NAME_PREFIX = get_tar_name_prefix()
        BRANCH_NAME = get_branch_name()
        EVENT_TYPE = get_event_type()
        REF_TYPE = get_ref_type()
        COMPANY_DEPARTMENT1_TEAM1_TENCENTCLOUD_SECRET_ID = credentials('COMPANY_DEPARTMENT1_TEAM1_TENCENTCLOUD_SECRET_ID') 
        COMPANY_DEPARTMENT1_TEAM1_TENCENTCLOUD_SECRET_KEY = credentials('COMPANY_DEPARTMENT1_TEAM1_TENCENTCLOUD_SECRET_KEY')
        COMPANY_DEPARTMENT2_TEAM3_TENCENTCLOUD_SECRET_ID = credentials('COMPANY_DEPARTMENT2_TEAM3_TENCENTCLOUD_SECRET_ID') 
        COMPANY_DEPARTMENT2_TEAM3_TENCENTCLOUD_SECRET_KEY = credentials('COMPANY_DEPARTMENT2_TEAM3_TENCENTCLOUD_SECRET_KEY')
        COMPANY_MASTER_TENCENTCLOUD_SECRET_ID = credentials('COMPANY_MASTER_TENCENTCLOUD_SECRET_ID') 
        COMPANY_MASTER_TENCENTCLOUD_SECRET_KEY = credentials('COMPANY_MASTER_TENCENTCLOUD_SECRET_KEY')
        
    }
    stages {
        stage('Clone') {
            steps {
                sh '''
                    git clone https://github.com/tencentcloudstack/jenkins-terraform.git
                    tar -zcvf $TAR_NAME_PREFIX-jenkins-terraform.tar.gz --exclude=.terragrunt-cache/  --exclude=.terraform.lock.hcl jenkins-terraform
                    cd jenkins-terraform
                    git fetch --all
                    git checkout $BRANCH_NAME
                    cd ..
                '''
                jf 'rt u $TAR_NAME_PREFIX-jenkins-terraform.tar.gz test-artifactory/'
                jf 'rt bp'
            }
        }
        
        stage('Init') {
            environment { 
                TEAM_PATH = "${sh(script:'find jenkins-terraform/deployments -name \"${TEAM_NAME}\" -type d -maxdepth 4', returnStdout: true).trim()}"
                
            }
            steps {
                dir("${TEAM_PATH}") {
                    sh '''
                        terragrunt run-all init -no-color
                    '''
                }
            }
        }
        
        stage('Validate') {
            environment { 
                TEAM_PATH = "${sh(script:'find jenkins-terraform/deployments -name \"${TEAM_NAME}\" -type d -maxdepth 4', returnStdout: true).trim()}"
            }
            steps {
                dir("${TEAM_PATH}") {
                    sh '''
                        terragrunt run-all validate -no-color
                    '''
                }
            }
        }
        
        stage('Plan') {
            environment { 
                TEAM_PATH = "${sh(script:'find jenkins-terraform/deployments -name \"${TEAM_NAME}\" -type d -maxdepth 4', returnStdout: true).trim()}"
            }
            steps {
                dir("${TEAM_PATH}") {
                    sh '''
                        terragrunt run-all plan -no-color
                    '''
                }
            }
        }
        
        stage('Opa') {
            environment { 
                TEAM_PATH = "${sh(script:'find jenkins-terraform/deployments -name \"${TEAM_NAME}\" -type d -maxdepth 4', returnStdout: true).trim()}"
            }
            steps {
                dir("${TEAM_PATH}") {
                    sh '''
                        terragrunt run-all plan -no-color --out /tmp/tfplan.binary
                        genopajson /tmp/tfplan.binary
                    '''
                    script {
                        
                        def opa_count = sh(returnStdout: true, script: 'opafailcount /tmp/tfplan.json').trim().toInteger()
                        def opa_info = sh(returnStdout: true, script: 'opainfo /tmp/tfplan.json')
                        
                        if (opa_count > 0) {
                            println opa_info
                            error('OPA check failed!')
                        }
                       
                    }
                }
            }
        }
        
        stage('Notify'){
            when {
                expression { EVENT_TYPE == "pull_request" }
            }
            steps{
                wxwork(
                    robot: 'benz',
                    type: 'markdown',
                    text: [
                            '# 有PR过来，请确认是否合入!',
                            '> [查看详情](http://xxxxxx)'
                    ]
                )
            }
            
        }
        
        stage('Confirm'){
            when {
                expression { EVENT_TYPE == "create" && REF_TYPE == "tag" }
            }
            steps{
                wxwork(
                    robot: 'benz',
                    type: 'markdown',
                    text: [
                            '# 有发布，请确认执行计划是否符合预期!',
                            '> [查看详情](http://xxxxxx)'
                    ]
                )
                script{
                    approvalMap = input (
                        message: '确认发布?',
                        ok: '确定',
                    )
                }

            }
        }
        
        stage('Apply') {
            when {
                expression { EVENT_TYPE == "create" && REF_TYPE == "tag" }
            }
            environment { 
                TEAM_PATH = "${sh(script:'find jenkins-terraform/deployments -name \"${TEAM_NAME}\" -type d -maxdepth 4', returnStdout: true).trim()}"
                 
            }
            steps {
                dir("${TEAM_PATH}") {
                    sh '''
                        terragrunt run-all apply --terragrunt-non-interactive -no-color
                    '''
                }
            }
        }
        
    }
    post { 
        always { 
            cleanWs()
        }
    }
}

def get_event_type() {
    node {
        return env.x_github_event
    }
}

def get_ref_type() {
    node {
        return env.ref_type
    }
}

def get_team_name() {
    node {
        if (env.x_github_event == "create" && env.ref_type == "tag") {
            return env.ref.split('#')[0]
        }
        return env.pull_request_branch.split('/')[0]
    }
}
def get_tar_name_prefix() {
    node {
        if (env.x_github_event == "create" && env.ref_type == "tag") {
            return env.ref.replace('/', '-')
        }
        return env.pull_request_branch.replace('/', '-')
    }
}
def get_branch_name() {
    node {
        if (env.x_github_event == "create" && env.ref_type == "tag") {
            return "main"
        }
        return env.pull_request_branch
    }
}