# Intel GPU Exporter

Python based metrics exporter for Prometheus.

The intel-gpu-tools package is used to extract GPU metrics.

# Usage:

Run container:

```
```

Or docker-compose:

```
```
/dev/dri is essential for GPU usage, and the container must operate with elevated privileges and as the root user to ensure adequate GPU access.

You can collect metrics after start container at the following address:

```
http://localhost:8000/metrics
```

Or you can run script manually, just run:

```
python3 exporter.py
```

# Prometheus setup

You can use this configuration to collect metrics:

```
  - job_name: gpu_metrics
    honor_timestamps: true
    scrape_interval: 15s
    scrape_timeout: 10s
    scheme: http
    follow_redirects: true
    static_configs:
    - targets:
      - localhost:8000
```

# Building a container from sources

Building:

```
docker build -t intel-gpu-exporter .
```
