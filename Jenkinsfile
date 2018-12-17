pipeline
{
//	agent any
//	agent{ label "slave-linux"}
//	Begin
	agent none
	environment 
	{
		//My-Sql Server
		DEFAULT_DB_ARROWHEAD_USR = "cpsiot"
		DEFAULT_DB_ARROWHEAD_PSW = "20cpsiot18"
		DEFAULT_DB_ROOT_PSW = "20cpsiot18"
		DB_ARROWHEAD = "cpsiot"
		DB_ARROWHEAD_LOG = "log"
		MY_SQL_SERVICE = "my-sql-server-cloud1"
		MY_SQL_SERVICE_TO_REMOVE = "my-sql-server-cloud1"
		MY_SQL_SERVICE_ADRESS = "my-sql-server-cloud1"
		MY_SQL_SERVICE_VOLUME = "my-sql-server-cloud1-storage"
		MY_SQL_SERVER_IMAGE_REPO = "${env.DOCKER_REPO}"
		MY_SQL_SERVER_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		MY_SQL_SERVER_IMAGE_NAME = "my-sql-server"
		MY_SQL_SERVER_IMAGE_TAG = "${env.BUILD_NUMBER}"
		MY_SQL_SERVER_PUBLISHED_PORT = "3306"
		MY_SQL_SERVER_TARGET_PORT = "3306"
		//MYSQL_ROOT_PASSWORD = credentials('my-sql-server-root-password')
		//MYSQL_ROOT_HOST = "%"
		//DB_ARROWHEAD = "arrowhead_test_cloud_1"
		//DB_ARROWHEAD_LOG = "log"
		//DEFAULT_DB_ARROWHEAD = credentials('default_creds_mysql_arrowhead')
		//PHP MyAdmin
		//PHP_MYADMIN = "php-myadmin-cloud1"
		//PHP_MYADMIN_TO_REMOVE = "php-myadmin-cloud1"
		//PHP_MYADMIN_ADRESS = "php-myadmin-cloud1"
		//PHP_MYDADMIN_IMAGE = "${env.DOCKER_REPO}/${env.DOCKER_USER_NAMESPACE}/my-phpmyadmin:1.0"
		//PHP_MYDADMIN_IMAGE_REPO = "${env.DOCKER_REPO}"
		//PHP_MYDADMIN_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		//PHP_MYDADMIN_IMAGE_NAME = "my-phpmyadmin"
		//PHP_MYDADMIN_IMAGE_TAG = "${env.BUILD_NUMBER}"
		//PHP_MYADMIN_PUBLISHED_PORT = "80"
		//PHP_MYADMIN_TARGET_PORT = "8080"
		//Service Registry
		SERVICE_REGISTRY = "registry-cloud1"
		SERVICE_REGISTRY_TO_REMOVE = "registry-cloud1"
		SERVICE_REGISTRY_ADRESS = "registry-cloud1"
		//SERVICE_REGISTRY_IMAGE = "${env.DOCKER_REPO}/${env.DOCKER_USER_NAMESPACE}/my-registry-sql:${env.BUILD_NUMBER}"
		SERVICE_REGISTRY_IMAGE_REPO = "${env.DOCKER_REPO}"
		SERVICE_REGISTRY_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		SERVICE_REGISTRY_IMAGE_NAME = "my-registry-sql"
		SERVICE_REGISTRY_IMAGE_TAG = "${env.BUILD_NUMBER}"
		SERVICE_REGISTRY_INSECURE_PORT = "8442"
		SERVICE_REGISTRY_SECURE_PORT = "8443"
		//Authorization
		AUTHORIZATION = "authorization-cloud1"
		AUTHORIZATION_TO_REMOVE = "authorization-cloud1"
		AUTHORIZATION_ADRESS = "authorization-cloud1"
		//AUTHORIZATION_IMAGE = "${env.DOCKER_REPO}/${env.DOCKER_USER_NAMESPACE}/my-authorization:${env.BUILD_NUMBER}"
		AUTHORIZATION_IMAGE_REPO = "${env.DOCKER_REPO}"
		AUTHORIZATION_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		AUTHORIZATION_IMAGE_NAME = "my-authorization"
		AUTHORIZATION_IMAGE_TAG = "${env.BUILD_NUMBER}"
		AUTHORIZATION_INSECURE_PORT = "8444"
		AUTHORIZATION_SECURE_PORT = "8445"
		//Gateway
		GATEWAY = "gateway-cloud1"
		GATEWAY_TO_REMOVE = "gateway-cloud1"
		GATEWAY_ADRESS = "gateway-cloud1"
		//GATEWAY_IMAGE = "${env.DOCKER_REPO}/${env.DOCKER_USER_NAMESPACE}/my-gateway:${env.BUILD_NUMBER}"
		GATEWAY_IMAGE_REPO = "${env.DOCKER_REPO}"
		GATEWAY_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		GATEWAY_IMAGE_NAME = "my-gateway"
		GATEWAY_IMAGE_TAG = "${env.BUILD_NUMBER}"
		GATEWAY_INSECURE_PORT = "8452"
		GATEWAY_SECURE_PORT = "8453"
		//eventhandler
		EVENTHANDLER = "eventhandler-cloud1"
		EVENTHANDLER_TO_REMOVE = "eventhandler-cloud1"
		EVENTHANDLER_ADRESS = "eventhandler-cloud1"
		//EVENTHANDLER_IMAGE = "${env.DOCKER_REPO}/${env.DOCKER_USER_NAMESPACE}/my-eventhandler:${env.BUILD_NUMBER}"
		EVENTHANDLER_IMAGE_REPO = "${env.DOCKER_REPO}"
		EVENTHANDLER_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		EVENTHANDLER_IMAGE_NAME = "my-eventhandler"
		EVENTHANDLER_IMAGE_TAG = "${env.BUILD_NUMBER}"
		EVENTHANDLER_INSECURE_PORT = "8454"
		EVENTHANDLER_SECURE_PORT = "8455"
		//Gatekeeper
		GATEKEEPER = "gatekeeper-cloud1"
		GATEKEEPER_TO_REMOVE = "gatekeeper-cloud1"
		GATEKEEPER_ADRESS = "gatekeeper-cloud1"
		//GATEKEEPER_IMAGE = "${env.DOCKER_REPO}/${env.DOCKER_USER_NAMESPACE}/my-gatekeeper:${env.BUILD_NUMBER}"
		GATEKEEPER_IMAGE_REPO = "${env.DOCKER_REPO}"
		GATEKEEPER_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		GATEKEEPER_IMAGE_NAME = "my-gatekeeper"
		GATEKEEPER_IMAGE_TAG = "${env.BUILD_NUMBER}"
		GATEKEEPER_INTERNAL_INSECURE_PORT = "8446"
		GATEKEEPER_INTERNAL_SECURE_PORT = "8447"
		GATEKEEPER_EXTERNAL_INSECURE_PORT = "8448"
		GATEKEEPER_EXTERNAL_SECURE_PORT = "8449"
		//Orchestrator
		ORCHESTRATOR = "orchestrator-cloud1"
		ORCHESTRATOR_TO_REMOVE = "orchestrator-cloud1"
		ORCHESTRATOR_ADRESS = "orchestrator-cloud1"
		//ORCHESTRATOR_IMAGE = "${env.DOCKER_REPO}/${env.DOCKER_USER_NAMESPACE}/my-orchestrator:${env.BUILD_NUMBER}"
		ORCHESTRATOR_IMAGE_REPO = "${env.DOCKER_REPO}"
		ORCHESTRATOR_IMAGE_NAMESPACE = "${env.DOCKER_USER_NAMESPACE}"
		ORCHESTRATOR_IMAGE_NAME = "my-orchestrator"
		ORCHESTRATOR_IMAGE_TAG = "${env.BUILD_NUMBER}"
		ORCHESTRATOR_INSECURE_PORT = "8440"
		ORCHESTRATOR_SECURE_PORT = "8441"
		//Cloud1 network
		NETWORK = "my-cloud1"
	}
	
	stages
	{
		
		stage("Create Maven Cache")
		{
			agent{ label "master"}
			steps
			{
				sh " docker volume create maven-repo "
			}
		}
		
		stage( "Build" )
		{
			agent
			{
				docker
				{
//					image "${env.DOCKER_REPO}/${env.DOCKER_BUILD_USER_NAMESPACE}/my-maven:latest"
					image 'maven:3-alpine'
//					args  " -u root -v maven-repo:/root/.m2 "
					args ' -v maven-repo:/root/.m2 '
//					reuseNode true
					label "master"
				}
			}
			steps
			{
				sh  " mvn "				
			}
		}
		
		stage( "Stash Artifacts" )
		{
			agent{ label "master" }
			steps
			{
				stash name: "auth-artifacts", includes: "authorization/target/**"
				stash name: "serv-artifacts", includes: "serviceregistry_sql/target/**"
				stash name: "event-artifacts", includes: "eventhandler/target/**"
				stash name: "keeper-artifacts", includes: "gatekeeper/target/**"
				stash name: "way-artifacts", includes: "gateway/target/**"
				stash name: "orch-artifacts", includes: "orchestrator/target/**"
			}
		}

		stage( "Generate My-Sql Startup SQL" )
		{
		
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				sh " printenv "
				sh " chmod +x gen_app_properties/gen_sql.sh "
				sh " gen_app_properties/gen_sql.sh "
//				sh " cat database_scripts/create_iot_user.sql "
			}
		}
		
		stage( "Dockerize My-SQl-Server" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				// This step should not normally be used in your script. Consult the inline help for details.
				script
				{
					// clean up possibly old generated script-output
					sh " rm -f $WORKSPACE/database_scripts/init_db.sql "
					sh " rm -f $WORKSPACE/database_scripts/Dockerfile"
					
					// generate Dockerfile with agent local architecture flavour
					sh " echo 'FROM ${MY_SQL_SERVER_IMAGE_REPO}/${env.DOCKER_USER_NAMESPACE}/${env.MY_SQL_IMAGE_BUILD}-${params.Architecture}' >> database_scripts/Dockerfile "
					sh " cat database_scripts/Dockerfile_Commands >> database_scripts/Dockerfile "
					sh " cat database_scripts/Dockerfile "
					sh " chmod +x database_scripts/gen_init_db.sh "
					sh " database_scripts/gen_init_db.sh && cp init_db.sql $WORKSPACE/database_scripts && rm -f init_db.sql"
					
					//customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${MY_SQL_SERVER_IMAGE_NAME}-${params.Architecture}", "$WORKSPACE/database_scripts")
					
										
					docker.withRegistry("https://${MY_SQL_SERVER_IMAGE_REPO}", 'demo-user')
					{
						customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${MY_SQL_SERVER_IMAGE_NAME}-${params.Build}-${params.Architecture}", "$WORKSPACE/database_scripts")
						customImage.push("latest")
						customImage.push("${env.BUILD_NUMBER}")
						// sh " cd database_scripts && cat Dockerfile"
						
					}
					
					sh "echo ${env.JAVA_IMAGE} "
				}
			}
		}
		
		
		stage( "Generate Application Properties" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				sh " chmod +x gen_app_properties/gen_app_properties.sh "
				sh " gen_app_properties/gen_app_properties.sh "
			}
		}
		
		stage( "Dockerize Registry SQL" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				//clean up old dockerfile if any
				sh " rm -f $WORKSPACE/serviceregistry_sql/Dockerfile"
				
				unstash "serv-artifacts"				
				sh " echo 'FROM ${SERVICE_REGISTRY_IMAGE_REPO}/${env.DOCKER_USER_NAMESPACE}/${env.JAVA_IMAGE_BUILD_ORACLE}-${params.Architecture}' >> $WORKSPACE/serviceregistry_sql/Dockerfile "
				sh " cat serviceregistry_sql/Dockerfile_Commands >> serviceregistry_sql/Dockerfile "
				
				script
				{
					docker.withRegistry("https://${SERVICE_REGISTRY_IMAGE_REPO}", 'demo-user')
					{
						customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${SERVICE_REGISTRY_IMAGE_NAME}-${params.Build}-${params.Architecture}", "$WORKSPACE/serviceregistry_sql")
						customImage.push("latest")
						customImage.push("${env.BUILD_NUMBER}")
						
					}
					
				}
			}
		}
		
		stage( "Dockerize Authorization" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				sh " rm -f $WORKSPACE/authorization/Dockerfile"
				unstash "auth-artifacts"
				
				
				sh " echo 'FROM ${SERVICE_REGISTRY_IMAGE_REPO}/${env.DOCKER_USER_NAMESPACE}/${env.JAVA_IMAGE_BUILD_ORACLE}-${params.Architecture}' >> $WORKSPACE/authorization/Dockerfile "
				sh " cat authorization/Dockerfile_Commands >> authorization/Dockerfile "
				
				script
				{
				
					docker.withRegistry("https://${AUTHORIZATION_IMAGE_REPO}", 'demo-user')
					{
						customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${AUTHORIZATION_IMAGE_NAME}-${params.Build}-${params.Architecture}", "$WORKSPACE/authorization")
						customImage.push("latest")
						customImage.push("${env.BUILD_NUMBER}")
						
					}
					
				}
			}
		}
		
		stage( "Dockerize Gateway" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				sh " rm -f $WORKSPACE/gateway/Dockerfile "
				unstash "way-artifacts"
				
				sh " echo 'FROM ${SERVICE_REGISTRY_IMAGE_REPO}/${env.DOCKER_USER_NAMESPACE}/${env.JAVA_IMAGE_BUILD_ORACLE}-${params.Architecture}' >> $WORKSPACE/gateway/Dockerfile "
				sh " cat gateway/Dockerfile_Commands >> gateway/Dockerfile "
				
				script
				{
					docker.withRegistry("https://${GATEWAY_IMAGE_REPO}", 'demo-user')
					{
						customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${GATEWAY_IMAGE_NAME}-${params.Build}-${params.Architecture}", "$WORKSPACE/gateway")
						customImage.push("latest")
						customImage.push("${env.BUILD_NUMBER}")
						
					}
					
				}
			}
		}
		
		stage( "Dockerize Event-Handler" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				sh " rm -f $WORKSPACE/eventhandler/Dockerfile "
				unstash "event-artifacts"
				
				sh " echo 'FROM ${SERVICE_REGISTRY_IMAGE_REPO}/${env.DOCKER_USER_NAMESPACE}/${env.JAVA_IMAGE_BUILD_ORACLE}-${params.Architecture}' >> $WORKSPACE/eventhandler/Dockerfile "
				sh " cat eventhandler/Dockerfile_Commands >> eventhandler/Dockerfile "
				
				script
				{
					docker.withRegistry("https://${EVENTHANDLER_IMAGE_REPO}", 'demo-user')
					{
						customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${EVENTHANDLER_IMAGE_NAME}-${params.Build}-${params.Architecture}", "$WORKSPACE/eventhandler")
						customImage.push("latest")
						customImage.push("${env.BUILD_NUMBER}")
						
					}
					
				}
			}
		}
		
		stage( "Dockerize Gate-Keeper" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				sh " rm -f $WORKSPACE/gatekeeper/Dockerfile "
				unstash "keeper-artifacts"
				
				sh " echo 'FROM ${SERVICE_REGISTRY_IMAGE_REPO}/${env.DOCKER_USER_NAMESPACE}/${env.JAVA_IMAGE_BUILD_ORACLE}-${params.Architecture}' >> $WORKSPACE/gatekeeper/Dockerfile "
				sh " cat gatekeeper/Dockerfile_Commands >> gatekeeper/Dockerfile "
				
				script
				{
					docker.withRegistry("https://${GATEKEEPER_IMAGE_REPO}", 'demo-user')
					{
						customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${GATEKEEPER_IMAGE_NAME}-${params.Build}-${params.Architecture}", "$WORKSPACE/gatekeeper")
						customImage.push("latest")
						customImage.push("${env.BUILD_NUMBER}")
						
					}
					
				}
			}
		}
		
		stage( "Dockerize Orchestrator" )
		{
			agent{ label "build && ${params.Architecture} && cpsiot"}
			steps
			{
				sh " rm -f $WORKSPACE/orchestrator/Dockerfile "
				unstash "orch-artifacts"
				
				sh " echo 'FROM ${SERVICE_REGISTRY_IMAGE_REPO}/${env.DOCKER_USER_NAMESPACE}/${env.JAVA_IMAGE_BUILD_ORACLE}-${params.Architecture}' >> $WORKSPACE/orchestrator/Dockerfile "
				sh " cat orchestrator/Dockerfile_Commands >> orchestrator/Dockerfile "
				
				// This step should not normally be used in your script. Consult the inline help for details.
				
				script
				{
					docker.withRegistry("https://${ORCHESTRATOR_IMAGE_REPO}", 'demo-user')
					{
						customImage = docker.build("${env.DOCKER_USER_NAMESPACE}/${ORCHESTRATOR_IMAGE_NAME}-${params.Build}-${params.Architecture}", "$WORKSPACE/orchestrator")
						customImage.push("latest")
						customImage.push("${env.BUILD_NUMBER}")
						
					}
					
				}
			}
		}
		
		/*
		stage( "Deploy Server Stack on Pi" )
		{
			agent
			{
				label "raspberry-pi1"
			}
			
			steps
			{
				script
				{
					//stop DB and PHP MyAdmin
					sh " docker stop ${MY_SQL_SERVICE_TO_REMOVE} || true"
					sh " docker rm ${MY_SQL_SERVICE_TO_REMOVE} || true"
						
					//stop the previously deployed arrowhead stack
					sh " docker stop ${SERVICE_REGISTRY_TO_REMOVE} || true"
					sh " docker rm ${SERVICE_REGISTRY_TO_REMOVE} || true"
					
					
					sh " docker stop ${AUTHORIZATION_TO_REMOVE} || true"
					sh " docker rm ${AUTHORIZATION_TO_REMOVE} || true"
					
					
					sh " docker stop ${GATEWAY_TO_REMOVE} || true"
					sh " docker rm ${GATEWAY_TO_REMOVE} || true"
					
					sh " docker stop ${EVENTHANDLER_TO_REMOVE} || true"
					sh " docker rm ${EVENTHANDLER_TO_REMOVE} || true"
					
					sh " docker stop ${GATEKEEPER_TO_REMOVE} || true"
					sh " docker rm ${GATEKEEPER_TO_REMOVE} || true"
					
					sh " docker stop ${ORCHESTRATOR_TO_REMOVE} || true"
					sh " docker rm ${ORCHESTRATOR_TO_REMOVE} || true"					
					
					//remove existing cloud network
					sh " docker network rm ${NETWORK} || true"
				}
					

				script
				{
					
					docker.withRegistry("https://${env.DOCKER_REPO}", 'demo-user')
					{
						//create network for arrowhead cloud
						sh " docker network create -d bridge ${NETWORK} "
						
						//start DB
						sh """ docker run -d  \
							   --name ${MY_SQL_SERVICE}  \
							   --network ${NETWORK} -p ${MY_SQL_SERVER_PUBLISHED_PORT}:${MY_SQL_SERVER_TARGET_PORT} \
							   -e MYSQL_ROOT_PASSWORD=${DEFAULT_DB_ROOT_PSW} \
							   ${MY_SQL_SERVER_IMAGE_REPO}/${MY_SQL_SERVER_IMAGE_NAMESPACE}/${MY_SQL_SERVER_IMAGE_NAME}-${params.Architecture}:${env.BUILD_NUMBER}
						   """
						
						sh " sleep 10"						
						
						//start service registry sql 
						sh """ docker run -d \
							   --name ${SERVICE_REGISTRY}  \
							   --network ${NETWORK} \
							   -p ${SERVICE_REGISTRY_INSECURE_PORT}:${SERVICE_REGISTRY_INSECURE_PORT} \
							   -p ${SERVICE_REGISTRY_SECURE_PORT}:${SERVICE_REGISTRY_SECURE_PORT} \
							   --hostname ${SERVICE_REGISTRY_ADRESS} \
							   ${SERVICE_REGISTRY_IMAGE_REPO}/${SERVICE_REGISTRY_IMAGE_NAMESPACE}/${SERVICE_REGISTRY_IMAGE_NAME}-${params.Architecture}:${env.BUILD_NUMBER}
						   """
						
						sh " sleep 10"
						
						//start service authorization
						sh """ docker run -d \
							   --name ${AUTHORIZATION} \
							   --network ${NETWORK} \
							   -p ${AUTHORIZATION_INSECURE_PORT}:${AUTHORIZATION_INSECURE_PORT} \
							   -p ${AUTHORIZATION_SECURE_PORT}:${AUTHORIZATION_SECURE_PORT} \
							   ${AUTHORIZATION_IMAGE_REPO}/${AUTHORIZATION_IMAGE_NAMESPACE}/${AUTHORIZATION_IMAGE_NAME}-${params.Architecture}:${env.BUILD_NUMBER}
						   """

						sh " sleep 10"
						
						//start service gateway
						sh """ docker run -d \
							   --name ${GATEWAY} \
							   --network ${NETWORK} \
							   -p ${GATEWAY_INSECURE_PORT}:${GATEWAY_INSECURE_PORT} \
							   -p ${GATEWAY_SECURE_PORT}:${GATEWAY_SECURE_PORT} \
							   ${GATEWAY_IMAGE_REPO}/${GATEWAY_IMAGE_NAMESPACE}/${GATEWAY_IMAGE_NAME}-${params.Architecture}:${env.BUILD_NUMBER}
						   """
						sh " sleep 10"
						
						//start service event-handler
						sh """ docker run -d \
							   --name ${EVENTHANDLER} \
							   --network ${NETWORK} \
							   -p ${EVENTHANDLER_INSECURE_PORT}:${EVENTHANDLER_INSECURE_PORT} \
							   -p ${EVENTHANDLER_SECURE_PORT}:${EVENTHANDLER_SECURE_PORT} \
							   ${EVENTHANDLER_IMAGE_REPO}/${EVENTHANDLER_IMAGE_NAMESPACE}/${EVENTHANDLER_IMAGE_NAME}-${params.Architecture}:${env.BUILD_NUMBER}
						   """
						sh " sleep 10"
						
						//start gate-keeper
						sh """ docker run -d \
							   --name ${GATEKEEPER} \
							   --network ${NETWORK} \
							   -p ${GATEKEEPER_INTERNAL_INSECURE_PORT}:${GATEKEEPER_INTERNAL_INSECURE_PORT} \
							   -p ${GATEKEEPER_INTERNAL_SECURE_PORT}:${GATEKEEPER_INTERNAL_SECURE_PORT} \
							   -p ${GATEKEEPER_EXTERNAL_INSECURE_PORT}:${GATEKEEPER_EXTERNAL_INSECURE_PORT} \
							   -p ${GATEKEEPER_EXTERNAL_SECURE_PORT}:${GATEKEEPER_EXTERNAL_SECURE_PORT} \
							   ${GATEKEEPER_IMAGE_REPO}/${GATEKEEPER_IMAGE_NAMESPACE}/${GATEKEEPER_IMAGE_NAME}-${params.Architecture}:${env.BUILD_NUMBER}
						   """
						sh " sleep 10"
						
						//start service orchestrator
						sh """ docker run -d \
							   --name ${ORCHESTRATOR} \
							   --network ${NETWORK} \
							   -p ${ORCHESTRATOR_INSECURE_PORT}:${ORCHESTRATOR_INSECURE_PORT} \
							   -p ${ORCHESTRATOR_SECURE_PORT}:${ORCHESTRATOR_SECURE_PORT} \
							   ${ORCHESTRATOR_IMAGE_REPO}/${ORCHESTRATOR_IMAGE_NAMESPACE}/${ORCHESTRATOR_IMAGE_NAME}-${params.Architecture}:${env.BUILD_NUMBER}
						   """

					}
				}
			}
		}
		*/
	}
	
	post
	{
		always
		{
			echo 'Runs always'
		}

		success
		{
			echo 'This will run only if successful'
		}
		
		failure
		{
			echo 'This will run only if failed'
		}
		
		unstable
		{
			echo 'This will run only if the run was marked as unstable'
		}
		
		changed
		{
			echo 'This will run only if the state of the Pipeline has changed'
			echo 'For example, the Pipeline was previously failing but is now successful'
		}
	}
}


	

		

