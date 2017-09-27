#! Groovy

pipeline {
    agent any
    stages {
        stage('Build_and_Test') {
            steps {
                sh 'cd builder; cpanm -L local --installdeps .'
                sh 'cd builder; prove -Ilocal/lib/perl5 --formatter=TAP::Formatter::JUnit --timer -wl t/ > testout.xml'
                archiveArtifacts artifacts: 'builder/local/**, builder/lib/**, builder/bin/**, builder/environments/**, config.yml, builder/views/**, builder/public/**'
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
                        credentialsId: '11da4872-4de5-40b3-903e-3789faf557eb',
                        url: 'ssh://git@source.test-smoke.org:9999/~/ztreet-configs'
                    ]]
                ])
                sh 'cp configs/perl.nl/production.yml deploy/environments/'
                archiveArtifacts artifacts: 'deploy/local/**, deploy/lib/**, deploy/bin/**, deploy/environments/**, config.yml, deploy/views/**, deploy/public/**'
            }
        }
    }
}
