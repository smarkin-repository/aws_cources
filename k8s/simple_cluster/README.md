# Simple cluster
## create
eksctl apply cluster --name simple-home-cluster --with-oidc --region eu-north-1
### of by file
cd ./cluster_configs
eksctl.exe apply cluster -f ./simple.yaml

## delete
eksctl delete cluster --name simple-home-cluster --region eu-north-1


# helps command
kubectl cluster-info

kubectl get nodes 

## get configuration
kubectl get svc

# Pod

## port forwading
kubectl.exe port-forward pod/nginx-deployment-66f7b9dc7b-9m9l7 8080:80

## run simple pod with externel access nginx
https://aws.amazon.com/ru/premiumsupport/knowledge-center/eks-kubernetes-services-cluster/

    aws eks update-kubeconfig --name base --region eu-north-1
    cd web_base/
    kubectl.exe apply -f ./deployment.yaml
    kubectl.exe apply -f ./autoscaling.yaml
    kubectl.exe get pods
    kubectl.exe apply -f ./loadbalancer.yaml
    kubectl.exe describe service/nginx-service
    curl ***.eu-north-1.elb.amazonaws.com

of

    kubectl.exe port-forward pod/nginx-deployment-66f7b9dc7b-9m9l7 8080:80

## complite cources https://www.udemy.com/course/rus-kubernetes/
ACC: cluster + helm chart with nginx base application 
 -  listnen cource and create simple cluster (*)
 -  certificate let's crypte
 -  helm chart if just public nginx (**)
 -  helm chart if own nginx base application from private reposiry (***)
 -  solve issue with authorization to k8s via AWS Console (****)
 https://serverfault.com/questions/916022/kubectl-cannot-authenticate-with-aws-eks/970708

 -

## scaling

kubectl.exe scale deployments nginx-deployment --replicas=2

## rollout

kubectl.exe rollout status deployment/nginx-deployment

## get access pull docker images from 500480925365.dkr.ecr.eu-north-1.amazonaws.com/rp
### login
aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 500480925365.dkr.ecr.eu-north-1.amazonaws.com/simple_app

## get access to ecr for helm
TOKEN=$(aws ecr get-authorization-token --output text --query 'authorizationData[].authorizationToken')
helm registry login --password $TOKEN --username AWS 500480925365.dkr.ecr.eu-north-1.amazonaws.com/simple_app:0.0.2
or
aws ecr get-login-password  --region eu-north-1 | helm registry login --username AWS --password-stdin 500480925365.dkr.ecr.eu-north-1.amazonaws.com/rp

## get access to ecr for k8s
https://medium.com/@danieltse/pull-the-docker-image-from-aws-ecr-in-kubernetes-dc7280d74904


TOKEN=$(aws ecr get-authorization-token --output text --query 'authorizationData[].authorizationToken')

kubectl create secret docker-registry regcred --docker-server=500480925365.dkr.ecr.eu-north-1.amazonaws.com/simple_app --docker-username=AWS --docker-password=$TOKEN --docker-email=ssmarkin.it@gmail.com

kubectl.exe get secret regcred --output=yaml

500480925365.dkr.ecr.eu-north-1.amazonaws.com/simple_app:0.0.2

## prepared image for WEB : first page + nigx (or analog) 

## prepared iamge for cli applications: aws-cli, bash, net tools, terraform, ansible ...

## prepared iamge for WEB server on Java 



# ingress controler AWS Load Balancer Controller
https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html



### RBAC

https://kubernetes.io/docs/reference/access-authn-authz/rbac/
https://habr.com/ru/company/flant/blog/422801/
https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html




### Tasks

1) поднять pod с другим образом
2) вернуть старый образ
3) переклюситься на новый образ

4) подключится к поду без LB