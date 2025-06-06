exp_name='mip12'
scenes=("bicycle" "bonsai" "counter" "garden" "kitchen" "room" "stump")
dataset_path='/home/ubuntu/Documents/dataset/mipnerf360'
n_views=12

for scene in "${scenes[@]}"
do
  echo "Training on $scene..."
  #export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True 
  python train.py -s $dataset_path/$scene/ \
    -m output/$exp_name/$scene \
    --eval -r 8 \
    --save_iterations 5000 10000 \
    --n_views $n_views

  echo "Rendering $scene..."
  python render.py -m output/$exp_name/$scene -r 8
done

# Compute metrics for all scenes
python metric.py --path output/$exp_name
