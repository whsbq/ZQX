#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# author: xiaoya li
# file: ner_ontonotes/bert.sh
# Result:
# Test F1: 80.54, Precision: 78.87, Recall: 82.29
# gpu4: /data/xiaoya/outputs/glyce/baselines/0121/onto_base_bert_5_16_3e-5_0.01_0.001_275_0.1_1_0.25

TIME=0820
FILE_NAME=onto_base_bert
REPO_PATH=/data/xiaoya/workspace/ChineseBert
BERT_PATH=/data/xiaoya/pretrain_lm/chinese_L-12_H-768_A-12
TASK=ontonotes4
SAVE_TOPK=20
DATA_DIR=/data/xiaoya/datasets/ner/zhontonotes4

TRAIN_BATCH_SIZE=16
LR=3e-5
WEIGHT_DECAY=0.01
WARMUP_PROPORTION=0.001
MAX_LEN=275
MAX_EPOCH=5
DROPOUT=0.1
ACC_GRAD=1
VAL_CHECK_INTERVAL=0.25

OUTPUT_DIR=/data/xiaoya/outputs/glyce/baselines/${TIME}/${FILE_NAME}_${MAX_EPOCH}_${TRAIN_BATCH_SIZE}_${LR}_${WEIGHT_DECAY}_${WARMUP_PROPORTION}_${MAX_LEN}_${DROPOUT}_${ACC_GRAD}_${VAL_CHECK_INTERVAL}
mkdir -p $OUTPUT_DIR
export PYTHONPATH="$PYTHONPATH:$REPO_PATH"

CUDA_VISIBLE_DEVICES=2 python3 $REPO_PATH/tasks/baseline/tagging_trainer.py \
--lr ${LR} \
--max_epochs ${MAX_EPOCH} \
--max_length ${MAX_LEN} \
--weight_decay ${WEIGHT_DECAY} \
--hidden_dropout_prob ${DROPOUT} \
--warmup_proportion ${WARMUP_PROPORTION}  \
--train_batch_size ${TRAIN_BATCH_SIZE} \
--accumulate_grad_batches ${ACC_GRAD} \
--save_topk ${SAVE_TOPK} \
--bert_path ${BERT_PATH} \
--data_dir ${DATA_DIR} \
--task ${TASK} \
--save_path ${OUTPUT_DIR} \
--val_check_interval ${VAL_CHECK_INTERVAL} \
--gpus="1"




