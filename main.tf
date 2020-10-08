resource "null_resource" "minikubeservice" {
	  provisioner "local-exec" {
	    command = "minikube service list"
	    
	  }
	  depends_on = [
	      kubernetes_deployment.abhipress,
	      kubernetes_service.abhilb,
	      aws_db_instance.abhidb
	 
	     ]
	}
