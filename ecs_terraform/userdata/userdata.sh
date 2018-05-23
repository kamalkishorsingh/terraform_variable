#!/bin/bash

# Update ECS Config File

echo "ECS_CLUSTER=FL-Dev" >> /etc/ecs/ecs.config
echo 'ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=6h' >> /etc/ecs/ecs.config
echo 'ECS_DISABLE_IMAGE_CLEANUP=false' >> /etc/ecs/ecs.config
echo 'ECS_IMAGE_CLEANUP_INTERVAL=1h' >> /etc/ecs/ecs.config
echo 'ECS_IMAGE_MINIMUM_CLEANUP_AGE=3h' >> /etc/ecs/ecs.config
echo 'ECS_NUM_IMAGES_DELETE_PER_CYCLE=5' >> /etc/ecs/ecs.config
