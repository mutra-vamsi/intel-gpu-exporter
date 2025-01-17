# Intel GPU Exporter

Python based metrics exporter for Prometheus.

The intel-gpu-tools package is used to extract GPU metrics.

# Usage:

Run container:

```
sudo docker run -d   --device /dev/dri:/dev/dri   --privileged   --publish 8000:8000   --restart always   --name intel-gpu-exporter   vamsimutra23/intel-gpu-exporter:latest

```

/dev/dri is essential for GPU usage, and the container must operate with elevated privileges and as the root user to ensure adequate GPU access.

You can collect metrics after start container at the following address:

```
http://localhost:8000/metrics
```

## Metrics

```
# HELP python_gc_objects_collected_total Objects collected during gc
# TYPE python_gc_objects_collected_total counter
python_gc_objects_collected_total{generation="0"} 102.0
python_gc_objects_collected_total{generation="1"} 289.0
python_gc_objects_collected_total{generation="2"} 0.0
# HELP python_gc_objects_uncollectable_total Uncollectable objects found during GC
# TYPE python_gc_objects_uncollectable_total counter
python_gc_objects_uncollectable_total{generation="0"} 0.0
python_gc_objects_uncollectable_total{generation="1"} 0.0
python_gc_objects_uncollectable_total{generation="2"} 0.0
# HELP python_gc_collections_total Number of times this generation was collected
# TYPE python_gc_collections_total counter
python_gc_collections_total{generation="0"} 42.0
python_gc_collections_total{generation="1"} 3.0
python_gc_collections_total{generation="2"} 0.0
# HELP python_info Python platform information
# TYPE python_info gauge
python_info{implementation="CPython",major="3",minor="10",patchlevel="12",version="3.10.12"} 1.0
# HELP process_virtual_memory_bytes Virtual memory size in bytes.
# TYPE process_virtual_memory_bytes gauge
process_virtual_memory_bytes 4.06728704e+08
# HELP process_resident_memory_bytes Resident memory size in bytes.
# TYPE process_resident_memory_bytes gauge
process_resident_memory_bytes 2.301952e+07
# HELP process_start_time_seconds Start time of the process since unix epoch in seconds.
# TYPE process_start_time_seconds gauge
process_start_time_seconds 1.73702273258e+09
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 39.68
# HELP process_open_fds Number of open file descriptors.
# TYPE process_open_fds gauge
process_open_fds 9.0
# HELP process_max_fds Maximum number of open file descriptors.
# TYPE process_max_fds gauge
process_max_fds 1.048576e+06
# HELP igpu_engines_blitter_0_busy Blitter 0 busy utilisation %
# TYPE igpu_engines_blitter_0_busy gauge
igpu_engines_blitter_0_busy 0.0
# HELP igpu_engines_blitter_0_sema Blitter 0 sema utilisation %
# TYPE igpu_engines_blitter_0_sema gauge
igpu_engines_blitter_0_sema 0.0
# HELP igpu_engines_blitter_0_wait Blitter 0 wait utilisation %
# TYPE igpu_engines_blitter_0_wait gauge
igpu_engines_blitter_0_wait 0.0
# HELP igpu_engines_render_3d_0_busy Render 3D 0 busy utilisation %
# TYPE igpu_engines_render_3d_0_busy gauge
igpu_engines_render_3d_0_busy 0.156212
# HELP igpu_engines_render_3d_0_sema Render 3D 0 sema utilisation %
# TYPE igpu_engines_render_3d_0_sema gauge
igpu_engines_render_3d_0_sema 0.0
# HELP igpu_engines_render_3d_0_wait Render 3D 0 wait utilisation %
# TYPE igpu_engines_render_3d_0_wait gauge
igpu_engines_render_3d_0_wait 0.0
# HELP igpu_engines_video_0_busy Video 0 busy utilisation %
# TYPE igpu_engines_video_0_busy gauge
igpu_engines_video_0_busy 0.0
# HELP igpu_engines_video_0_sema Video 0 sema utilisation %
# TYPE igpu_engines_video_0_sema gauge
igpu_engines_video_0_sema 0.0
# HELP igpu_engines_video_0_wait Video 0 wait utilisation %
# TYPE igpu_engines_video_0_wait gauge
igpu_engines_video_0_wait 0.0
# HELP igpu_engines_video_enhance_0_busy Video Enhance 0 busy utilisation %
# TYPE igpu_engines_video_enhance_0_busy gauge
igpu_engines_video_enhance_0_busy 0.0
# HELP igpu_engines_video_enhance_0_sema Video Enhance 0 sema utilisation %
# TYPE igpu_engines_video_enhance_0_sema gauge
igpu_engines_video_enhance_0_sema 0.0
# HELP igpu_engines_video_enhance_0_wait Video Enhance 0 wait utilisation %
# TYPE igpu_engines_video_enhance_0_wait gauge
igpu_engines_video_enhance_0_wait 0.0
# HELP igpu_frequency_actual Frequency actual MHz
# TYPE igpu_frequency_actual gauge
igpu_frequency_actual 179.188128
# HELP igpu_frequency_requested Frequency requested MHz
# TYPE igpu_frequency_requested gauge
igpu_frequency_requested 179.188128
# HELP igpu_imc_bandwidth_reads IMC reads MiB/s
# TYPE igpu_imc_bandwidth_reads gauge
igpu_imc_bandwidth_reads 0.0
# HELP igpu_imc_bandwidth_writes IMC writes MiB/s
# TYPE igpu_imc_bandwidth_writes gauge
igpu_imc_bandwidth_writes 0.0
# HELP igpu_interrupts Interrupts/s
# TYPE igpu_interrupts gauge
igpu_interrupts 20.798622
# HELP igpu_period Period ms
# TYPE igpu_period gauge
igpu_period 5000.331278
# HELP igpu_power_gpu GPU power W
# TYPE igpu_power_gpu gauge
igpu_power_gpu 0.778232
# HELP igpu_power_package Package power W
# TYPE igpu_power_package gauge
igpu_power_package 7.909474
# HELP igpu_rc6 RC6 %
# TYPE igpu_rc6 gauge
igpu_rc6 0.0
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
sudo docker build -t intel-core-gpu-exporter . --build-arg http_proxy="$http_proxy" --build-arg https_proxy="$https_proxy" --build-arg no_proxy="$no_proxy"
```
