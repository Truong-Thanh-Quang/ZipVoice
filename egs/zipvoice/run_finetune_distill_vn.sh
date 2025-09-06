#!/bin/bash

# Add project root to PYTHONPATH
export PYTHONPATH=../../:$PYTHONPATH

python3 -m zipvoice.bin.train_zipvoice_distill \
    --world-size 1 \
    --use-fp16 1 \
    --num-iters 60000 \
    --max-duration 340 \
    --base-lr 0.0005 \
    --tokenizer espeak \
    --lang vi \
    --token-file download/tokens.txt \
    --model-config download/model.json \
    --dataset custom \
    --teacher-model download/iter-10000-avg-2.pt \
    --distill-stage first \
    --exp-dir exp/zipvoice_distill_1stage \
    --train-manifest data/fbank/custom-finetune_cuts_train.jsonl.gz \
    --dev-manifest data/fbank/custom-finetune_cuts_dev.jsonl.gz \
    --start-epoch 1

curl --location 'https://n8n.zstackai.com/webhook/b427eda3-dc06-4278-bc4e-3682adfa8c95?program=ZipVoice'
