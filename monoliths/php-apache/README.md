# Performance Test with php-apache

## Preparation

Install metrics server

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

## Setup

Deploy php-apache deployment and service

```
kubectl apply -f deployment.yaml
```

Create `Horizontal Pod Autoscaler`

```
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```


