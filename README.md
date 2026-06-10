# RealSense SDK Base Container

Base image for the RealSense pipeline on a NVIDIA Jetson Orin (JetPack 6.1).  
Nothing runs here — this is the SDK layer that publisher nodes build on top of.

## Build

```bash
docker compose build
```

## Test

```bash
docker compose run --rm realsense-sdk
```

This runs `rs-enumerate-devices` inside the container. If the host driver is set up correctly you should see all connected cameras listed with their serial numbers and supported stream profiles.
