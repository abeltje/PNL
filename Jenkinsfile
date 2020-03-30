#! Groovy

pipeline {
    agent any
    stages {
        stage('Build_and_Test') {
            steps {
                script { echo "Building and testing branch: " + scm.branches[0].name }
                sh 'cpanm --notest -L local --installdeps .'
                sh 'cpanm --notest -L local Test::NoWarnings Plack Daemon::Control Starman'
                sh 'prove -Ilocal/lib/perl5 --formatter=TAP::Formatter::JUnit --timer -wl t/ > testout.xml'
                archiveArtifacts artifacts: 'local/**, lib/**, bin/**, environments/**, config.yml, views/**, public/**'
            }
            post {
                changed {
                    junit 'testout.xml'
                }
            }
        }
        stage('MergeConfig') {
            steps {
                step([$class: 'WsCleanup'])
                unarchive  mapping: ['**': 'deploy/']
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/master']],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [[
                        $class: 'RelativeTargetDirectory',
                        relativeTargetDir: 'configs'
                    ]],
                    submoduleCfg: [],
                    userRemoteConfigs: [[
                        credentialsId: '4c42570e-2cb1-4450-a1db-f4d37d34b019',
                        url: 'ssh://git@source.test-smoke.org:9999/~/ztreet-configs'
                    ]]
                ])
                script {
                    echo "Testing '${scm.branches[0].name}' for master..."
                    if (scm.branches[0].name == 'master') {
                        sh 'cp configs/perl.nl/production.yml deploy/environments/'
                    }
                    else {
                        sh 'cp configs/perl.nl/pnl-test.yml deploy/environments/'
                    }
                    sh 'chmod +x deploy/local/bin/*'
                }
                archiveArtifacts artifacts: 'deploy/**'
            }
        }
        stage('DeployPreview') {
//            when { branch 'pnl-test' }
            steps {
                script {
                    def usrinput = input message: "Deploy or Abort ?", ok: "Deploy!"
                }
            }
        }
    }
}
