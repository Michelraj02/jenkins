node{
   stage('SCM Checkout'){
     git 'https://github.com/Michelraj02/jenkins.git'
   }
   }
   stage('Compile-Package'){

      def mvnHome =  tool name: 'maven3', type: 'maven'
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
   stage('SonarQube Analysis') {
	        def mvnHome =  tool name: 'maven3', type: 'maven'
	        withSonarQubeEnv('sonar') { 
	          sh "${mvnHome}/bin/mvn sonar:sonar"
                }
	} 

	stage('Build Docker Imager'){
   sh 'docker build -t saidamo/myweb:0.0.2 .'
   } 
