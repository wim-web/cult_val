#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

# APIエンドポイントのURLを定義
API_URLS=("http://localhost:17690/health" "http://localhost:17691/health")

# 出力するpromファイルのパス
OUTPUT_FILE="${SCRIPT_DIR}/elixir_metrics.prom"
FINAL_OUTPUT_FILE="/var/lib/node_exporter/textfile_collector/elixir_metrics.prom"

# 各エンドポイントから疎通確認し、データを取得してプロメテウスフォーマットに変換
for API_URL in "${API_URLS[@]}"; do
    # 疎通確認（タイムアウトは2秒）
    if curl -s --connect-timeout 2 $API_URL > /dev/null; then
        # APIからデータを取得
        response=$(curl -s $API_URL)

        # JSONから必要なフィールドを抽出
        app_version=$(echo $response | jq -r '.app_version')
        status=$(echo $response | jq -r '.status')
        api_url=$(echo $response | jq -r '.["api url"]')

        # Prometheusフォーマットでエンドポイントごとにラベルを付与して書き出し
        echo "# HELP app_version The version of the application." >> $OUTPUT_FILE
        echo "# TYPE app_version gauge" >> $OUTPUT_FILE
        echo "app_version{api_url=\"$api_url\", version=\"$app_version\"} 1" >> $OUTPUT_FILE

        echo "# HELP status The authorization status of the application." >> $OUTPUT_FILE
        echo "# TYPE status gauge" >> $OUTPUT_FILE
        echo "status{api_url=\"$api_url\", status=\"$status\"} 1" >> $OUTPUT_FILE
    else
        :
    fi
done

mv $OUTPUT_FILE $FINAL_OUTPUT_FILE
