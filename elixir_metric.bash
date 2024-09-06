#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

# APIエンドポイントのURLを定義
API_URL="http://localhost:17690/metrics"

# 出力するpromファイルのパス
OUTPUT_FILE="${SCRIPT_DIR}/elixir_metrics.prom"
FINAL_OUTPUT_FILE="/var/lib/node_exporter/textfile_collector/elixir_metrics.prom"

# APIからデータを取得
response=$(curl -s $API_URL)

# JSONから必要なフィールドを抽出してPrometheusフォーマットに変換
started_at=$(echo $response | jq -r '.started_at')
data_frame_version=$(echo $response | jq -r '.data_frame_version')
order_proposal_version=$(echo $response | jq -r '.order_proposal_version')
app_version=$(echo $response | jq -r '.app_version')
status=$(echo $response | jq -r '.status')
data_frames_consumed=$(echo $response | jq -r '.data_frames_consumed')
proposals_produced=$(echo $response | jq -r '.proposals_produced')

# Prometheusフォーマットでファイルに書き出し
# echo "# HELP data_frames_consumed The number of data frames consumed." > $OUTPUT_FILE
# echo "# TYPE data_frames_consumed gauge" >> $OUTPUT_FILE
# echo "data_frames_consumed $data_frames_consumed" >> $OUTPUT_FILE

# echo "# HELP proposals_produced The number of proposals produced." >> $OUTPUT_FILE
# echo "# TYPE proposals_produced gauge" >> $OUTPUT_FILE
# echo "proposals_produced $proposals_produced" >> $OUTPUT_FILE

# 必要に応じて追加のフィールドを記録する
echo "# HELP app_version The version of the application." >> $OUTPUT_FILE
echo "# TYPE app_version gauge" >> $OUTPUT_FILE
echo "app_version{version=\"$app_version\"} 1" >> $OUTPUT_FILE

echo "# HELP status The authorization status of the application." >> $OUTPUT_FILE
echo "# TYPE status gauge" >> $OUTPUT_FILE
echo "status{status=\"$status\"} 1" >> $OUTPUT_FILE

mv $OUTPUT_FILE $FINAL_OUTPUT_FILE
