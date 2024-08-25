kubectl create namespace vote
namespace/vote created

kubectl apply -f vote-service.yaml
service/vote-service created

controlplane ~ ➜  kubectl apply -f deployment.yml
deployment.apps/vote-deployment created

kubectl apply -f redis.yml
service/redis created

kubectl apply -f redis-deply.yml
deployment.apps/redis-deployment created

 kubectl apply -f worker.yaml
deployment.apps/worker created

kubectl apply -f db.yaml
service/db created

 kubectl apply -f db-deploy.yml
deployment.apps/db-deployment created


kubectl apply -f result-deploy.yml
deployment.apps/result-deployment created

kubectl apply -f result-service.yml
service/result-service created
