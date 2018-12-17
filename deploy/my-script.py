import docker
import os
import time
import sys
#tls_config = docker.tls.TLSConfig(client_cert=('/usr/src/app/keys/client-cert.pem', '/usr/src/app/keys/client-key.pem'), ca_cert='/usr/src/app/keys/ca.pem' )
#tls_config = docker.tls.TLSConfig(client_cert=('/usr/src/app/keys/client-cert.pem', '/usr/src/app/keys/client-key.pem'), verify='/usr/src/app/keys/ca.pem' )
#client = docker.DockerClient(base_url='node1.docker:2376', tls=tls_config)
#services = client.services.list()
#print ( client.images.list() )

error_module_not_running = 1
error_module_not_found = 2
error_api_error = 3
error_container_not_stopped = 4
error_volume_not_removed = 5
error_container_wait_timed_out = 6
error_docker_not_found = 7
error_docker_api_error = 8
error_network_not_found = 9
error_network_ambigious = 10

def remove_container(name = None, clientApi = None):
	if not name or not clientApi:
		return False
	
	try:
		containers = clientApi.containers.list(all=True, filters={"name": name})
		
		if len(containers) > 0:
			#container exists stop and delete
			container = clientApi.containers.get(name)
			
			if "running" in container.status:
				print (name +  " running stop it" )
				container.stop(timeout=10)
			else:
				print (name +  " not running remove it" )
				container.remove()
			
			i = 0
			while i < 4:
				containers2 = clientApi.containers.list(all=True, filters={"name": name})
				if len(containers2) > 0:
					try:
						container = clientApi.containers.get(name)
						if "running" in container.status:
							print (name +  " running stop it" )
							container.stop(timeout=10)
						else:
							print (name +  " not running remove it" )
							container.remove()
					except docker.errors.APIError:
						print( "container remove exception for: " + name )
					
					i = i + 1
					time.sleep(10)
					continue
				else:
					print( "removed container " + name )
					return True
			
			if i == 4:
				print (name +  " remove took too long abort" )
				return False
		else:
			print( "removed container " + name )
			return True
				
	except docker.errors.NotFound:
		return False

	except docker.errors.APIError:
		return False

def remove_volume( name = None, clientApi = None ):
	if not name or not clientApi:
		return False
	
	try:
		volumes = clientApi.volumes.list(filters={"name": name})
		
		if len(volumes) > 0:
			try:
				volume = clientApi.volumes.get(name)
				volume.remove()
				print( "volume " + name + " removed" )
				return True
			except docker.errors.APIError:
				print( "failed to remove volume " + name + " trying again" )
			
			i = 0
			while i < 4:
				try:
					volumes2 = clientApi.volumes.list(filters={"name": name})
					if len(volumes) > 0:
						volume2 = clientApi.volumes.get(name)
						volume2.remove()
						return True
				except docker.errors.APIError:
					print( "failed to remove volume " + name + " try nr " + i )
				
				i = i + 1
				time.sleep(10)
				continue
			
			print( "Abort remove volume " + name + " after try nr " + i )
			return False
		else:
			print( "volume " + name + " removed" )
			return True
			
	except docker.errors.NotFound:
		return False

	except docker.errors.APIError:
		return False

def wait_for_container_running( name = None, clientApi = None ):
	if not name or not clientApi:
		return False
	time.sleep(10)
	try:
		container = clientApi.containers.get(name)
		i = 0
		while i < 4:
			if "running" in container.status:
				print (name +  "is running" )
				return True
			
			print( "Wait for container " + name + " try nr " + i )
			i = i + 1
			time.sleep(10)
		
		return False
	except docker.errors.NotFound:
		return False

	except docker.errors.APIError:
		return False

#check if network exists if not create it
try:
	
	client = docker.from_env()
	client.login(os.environ.get('USER'), os.environ.get('PASS') , registry=os.environ.get('DOCKER_REGISTRY_URL'))
	
	networks = client.networks.list(names=[os.environ.get('NETWORK')])
	
	if len( networks ) == 1:
		print( "network " + os.environ.get('NETWORK') + " already exists" )
	else:
		if len( networks ) == 0:
			print( "creating network " + os.environ.get('NETWORK') )
			client.networks.create(os.environ.get('NETWORK'), driver="bridge")
		if len( networks ) > 1:
			print( "network " + os.environ.get('NETWORK') + " ambigious ... abort" )
			sys.exit( error_network_ambigious )
			
	
	
	#stop containers and volumes
	if not remove_container( name=os.environ.get('MY_SQL_SERVICE_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	if not remove_volume(name = os.environ.get('MY_SQL_SERVICE_VOLUME'), clientApi = client ):
		sys.exit(error_volume_not_removed)
	
	if not remove_container( name=os.environ.get('PHP_MYADMIN_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	if not remove_container( name=os.environ.get('SERVICE_REGISTRY_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	if not remove_container( name=os.environ.get('AUTHORIZATION_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	if not remove_container( name=os.environ.get('GATEWAY_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	if not remove_container( name=os.environ.get('EVENTHANDLER_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	if not remove_container( name=os.environ.get('GATEKEEPER_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	if not remove_container( name=os.environ.get('ORCHESTRATOR_TO_REMOVE'), clientApi = client ):
		sys.exit(error_container_not_stopped)
	
	#create volume for db persistence
	client.volumes.create(name=os.environ.get('MY_SQL_SERVICE_VOLUME'), driver='local')
	
	#start my-sql-server
	image = os.environ.get('MY_SQL_SERVER_IMAGE')	
	client.containers.run(	image, detach=True, hostname=os.environ.get('MY_SQL_SERVICE_ADRESS'), name=os.environ.get('MY_SQL_SERVICE'),
							network=os.environ.get('NETWORK'), ports={os.environ.get('MY_SQL_SERVER_PUBLISHED_PORT')+"/tcp": int(os.environ.get('MY_SQL_SERVER_TARGET_PORT'))},
							restart_policy={"Name":"always"}, volumes={os.environ.get('MY_SQL_SERVICE_VOLUME'): {'bind': '/var/lib/mysql', 'mode': 'rw'}},
							environment=["MYSQL_ROOT_PASSWORD=" + os.environ.get('MYSQL_ROOT_PASSWORD'), "MYSQL_ROOT_HOST="+os.environ.get('MYSQL_ROOT_HOST')])
	
	
	
	if not wait_for_container_running( name = os.environ.get('MY_SQL_SERVICE'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('MY_SQL_SERVICE') )
		sys.exit(error_container_wait_timed_out)
	
	
	#start php my admin
	image = os.environ.get('PHP_MYDADMIN_IMAGE')
	client.containers.run(	image, detach=True, hostname=os.environ.get('PHP_MYADMIN_ADRESS'), name=os.environ.get('PHP_MYADMIN'),
							network=os.environ.get('NETWORK'), ports={os.environ.get('PHP_MYADMIN_PUBLISHED_PORT')+"/tcp": int(os.environ.get('PHP_MYADMIN_TARGET_PORT'))},
							restart_policy={"Name":"always"}, 
							environment=["PMA_HOST=" + os.environ.get('MY_SQL_SERVICE_ADRESS'), "PMA_PORT="+os.environ.get('MY_SQL_SERVER_TARGET_PORT')])
	
	if not wait_for_container_running( name = os.environ.get('PHP_MYADMIN'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('PHP_MYADMIN') )
		sys.exit(error_container_wait_timed_out)
	
	#start registry
	image = os.environ.get('SERVICE_REGISTRY_IMAGE')
	client.containers.run(	image, detach=True, hostname=os.environ.get('SERVICE_REGISTRY_ADRESS'), name=os.environ.get('SERVICE_REGISTRY'),
							network=os.environ.get('NETWORK'), 
							ports={	os.environ.get('SERVICE_REGISTRY_INSECURE_PORT')+"/tcp": int(os.environ.get('SERVICE_REGISTRY_INSECURE_PORT')),
									os.environ.get('SERVICE_REGISTRY_SECURE_PORT')+"/tcp": int(os.environ.get('SERVICE_REGISTRY_SECURE_PORT'))},
							restart_policy={"Name":"on-failure","MaximumRetryCount":3})
	
	if not wait_for_container_running( name = os.environ.get('SERVICE_REGISTRY'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('SERVICE_REGISTRY') )
		sys.exit(error_container_wait_timed_out)
	
	#start authorization
	image = os.environ.get('AUTHORIZATION_IMAGE')	
	client.containers.run(	image, detach=True, hostname=os.environ.get('AUTHORIZATION_ADRESS'), name=os.environ.get('AUTHORIZATION'),
							network=os.environ.get('NETWORK'), 
							ports={	os.environ.get('AUTHORIZATION_INSECURE_PORT')+"/tcp": int(os.environ.get('AUTHORIZATION_INSECURE_PORT')),
									os.environ.get('AUTHORIZATION_SECURE_PORT')+"/tcp": int(os.environ.get('AUTHORIZATION_SECURE_PORT'))},
							restart_policy={"Name":"on-failure","MaximumRetryCount":3})
	
	if not wait_for_container_running( name = os.environ.get('AUTHORIZATION'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('AUTHORIZATION') )
		sys.exit(error_container_wait_timed_out)
		
	
	#start gateway
	image = os.environ.get('GATEWAY_IMAGE')	
	client.containers.run(	image, detach=True, hostname=os.environ.get('GATEWAY_ADRESS'), name=os.environ.get('GATEWAY'),
							network=os.environ.get('NETWORK'), 
							ports={	os.environ.get('GATEWAY_INSECURE_PORT')+"/tcp": int(os.environ.get('GATEWAY_INSECURE_PORT')),
									os.environ.get('GATEWAY_SECURE_PORT')+"/tcp": int(os.environ.get('GATEWAY_SECURE_PORT'))},
							restart_policy={"Name":"on-failure","MaximumRetryCount":3})
	
	if not wait_for_container_running( name = os.environ.get('GATEWAY'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('GATEWAY') )
		sys.exit(error_container_wait_timed_out)

	#start event handler
	image = os.environ.get('EVENTHANDLER_IMAGE')
	client.containers.run(	image, detach=True, hostname=os.environ.get('EVENTHANDLER_ADRESS'), name=os.environ.get('EVENTHANDLER'),
							network=os.environ.get('NETWORK'), 
							ports={	os.environ.get('EVENTHANDLER_INSECURE_PORT')+"/tcp": int(os.environ.get('EVENTHANDLER_INSECURE_PORT')),
									os.environ.get('EVENTHANDLER_SECURE_PORT')+"/tcp": int(os.environ.get('EVENTHANDLER_SECURE_PORT'))},
							restart_policy={"Name":"on-failure","MaximumRetryCount":3})
	
	if not wait_for_container_running( name = os.environ.get('EVENTHANDLER'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('EVENTHANDLER') )
		sys.exit(error_container_wait_timed_out)

	#start gate keeper
	image = os.environ.get('GATEKEEPER_IMAGE')
	client.containers.run(	image, detach=True, hostname=os.environ.get('GATEKEEPER_ADRESS'), name=os.environ.get('GATEKEEPER'),
							network=os.environ.get('NETWORK'), 
							ports={	os.environ.get('GATEKEEPER_INTERNAL_INSECURE_PORT')+"/tcp": int(os.environ.get('GATEKEEPER_INTERNAL_INSECURE_PORT')),
									os.environ.get('GATEKEEPER_INTERNAL_SECURE_PORT')+"/tcp": int(os.environ.get('GATEKEEPER_INTERNAL_SECURE_PORT')),
									os.environ.get('GATEKEEPER_EXTERNAL_INSECURE_PORT')+"/tcp": int(os.environ.get('GATEKEEPER_EXTERNAL_INSECURE_PORT')),
									os.environ.get('GATEKEEPER_EXTERNAL_SECURE_PORT')+"/tcp": int(os.environ.get('GATEKEEPER_EXTERNAL_SECURE_PORT'))},
							restart_policy={"Name":"on-failure","MaximumRetryCount":3})
	
	if not wait_for_container_running( name = os.environ.get('GATEKEEPER'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('GATEKEEPER') )
		sys.exit(error_container_wait_timed_out)
	
	#start orchestrator
	image = os.environ.get('ORCHESTRATOR_IMAGE')
	client.containers.run(	image, detach=True, hostname=os.environ.get('ORCHESTRATOR_ADRESS'), name=os.environ.get('ORCHESTRATOR'),
							network=os.environ.get('NETWORK'), 
							ports={	os.environ.get('ORCHESTRATOR_INSECURE_PORT')+"/tcp": int(os.environ.get('ORCHESTRATOR_INSECURE_PORT')),
									os.environ.get('ORCHESTRATOR_SECURE_PORT')+"/tcp": int(os.environ.get('ORCHESTRATOR_SECURE_PORT'))},
							restart_policy={"Name":"on-failure","MaximumRetryCount":3})
	
	if not wait_for_container_running( name = os.environ.get('ORCHESTRATOR'), clientApi = client ):
		print( "wait_timed_out for " + os.environ.get('ORCHESTRATOR') )
		sys.exit(error_container_wait_timed_out)

except Exception as e:
	print(e.message)
	sys.exit(error_docker_not_found)
#except docker.errors.NotFound:
#	print( "Docker not Found Exception " )
#	sys.exit(error_docker_not_found)

#except docker.errors.APIError:
#	print( "Docker Api Error Exception " )
#	sys.exit(error_docker_api_error)

exit()
